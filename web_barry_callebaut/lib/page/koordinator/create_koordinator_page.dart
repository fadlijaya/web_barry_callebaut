import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_barry_callebaut/page/menu_page.dart';
import 'package:web_barry_callebaut/utils/constant.dart';

import '../../enum/enum.dart';
import '../../theme/colors.dart';
import '../../theme/padding.dart';

class CreateKoordinatorPage extends StatefulWidget {
  const CreateKoordinatorPage({Key? key}) : super(key: key);

  @override
  State<CreateKoordinatorPage> createState() => _CreateKoordinatorPageState();
}

class _CreateKoordinatorPageState extends State<CreateKoordinatorPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();
  JenisKelamin? _jekel = JenisKelamin.pria;
  final List<String> _listAgama = [
    'Islam',
    'Kristen',
    'Katolik',
    'Buddha',
    'Hindu',
    'Lainnya'
  ];
  var _selectAgama;
  late bool _showPassword1 = true;
  late bool _showPassword2 = true;

  void togglePasswordVisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }

  void togglePasswordVisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerNamaLengkap = TextEditingController();
  final TextEditingController _controllerNik = TextEditingController();
  final TextEditingController _controllerNoHp = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerLokasiKerja = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerKonfirmasiPassword =
      TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();

  Future<void> selectedDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: today);
    if (_datePicker != null) {
      _dateTime = _datePicker;
      _controllerTglLahir.text = DateFormat('dd/MM/yyyy').format(_dateTime);
    }
  }

  Future<dynamic> addDataToFirebase() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerPassword.text);

        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection(collectionKoordinator)
            .doc(user!.uid)
            .set({
          'uid': user.uid,
          'idNumber': _controllerIdNumber.text,
          'username': _controllerUsername.text,
          'nama lengkap': _controllerNamaLengkap.text,
          'nik': _controllerNik.text,
          'nomor hp': _controllerNoHp.text,
          'tanggal lahir': _controllerTglLahir.text,
          'lokasi kerja': _controllerLokasiKerja.text,
          'email': _controllerEmail.text,
          'alamat': _controllerAlamat.text,
          'agama': _selectAgama.toString(),
          'jenis kelamin': _jekel.toString()
        }).then((value) {
          Future.delayed(const Duration(seconds: 3), (() => statusDialog()));
        });
      } catch (e) {
        return e.toString();
      }
    }
  }

  statusDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: 60,
                  color: kGreen2,
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Data Berhasil di Submit")
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Tutup",
                    style: TextStyle(color: kGreen2),
                  ))
            ],
          );
        });
  }

  @override
  void dispose() {
    _controllerIdNumber.clear();
    _controllerUsername.clear();
    _controllerNamaLengkap.clear();
    _controllerNik.clear();
    _controllerNoHp.clear();
    _controllerTglLahir.clear();
    _controllerLokasiKerja.clear();
    _controllerEmail.clear();
    _controllerAlamat.clear();
    _selectAgama;
    _jekel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              formList(),
              const SizedBox(
                height: 12,
              ),
              buttonSubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget formList() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 300),
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _controllerIdNumber,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan ID Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerUsername,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerNamaLengkap,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Nama Lengkap'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerNik,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 16,
                  decoration: const InputDecoration(labelText: 'Masukkan NIK'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerNoHp,
                  keyboardType: TextInputType.phone,
                  maxLength: 13,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: 'Masukkan Nomor Handphone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerTglLahir,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.today),
                      labelText: 'Masukkan Tanggal Lahir'),
                  readOnly: true,
                  onTap: () => selectedDate(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerLokasiKerja,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Lokasi Kerja'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text("Jenis Kelamin"),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: kGreen2,
                        value: JenisKelamin.pria,
                        groupValue: _jekel,
                        onChanged: (JenisKelamin? value) {
                          setState(() {
                            _jekel = value;
                          });
                        }),
                    const Text("Pria"),
                    const SizedBox(
                      width: 24,
                    ),
                    Radio(
                        activeColor: kGreen2,
                        value: JenisKelamin.wanita,
                        groupValue: _jekel,
                        onChanged: (JenisKelamin? value) {
                          setState(() {
                            _jekel = value;
                          });
                        }),
                    const Text("Wanita"),
                  ],
                ),
                TextFormField(
                  controller: _controllerAlamat,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Alamat'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                DropdownButton(
                  items: _listAgama
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (selected) {
                    setState(() {
                      _selectAgama = selected;
                    });
                  },
                  isExpanded: true,
                  value: _selectAgama,
                  hint: const Text('Agama'),
                ),
                TextFormField(
                  controller: _controllerEmail,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: _showPassword1,
                  controller: _controllerPassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: togglePasswordVisibility1,
                      child: _showPassword1
                          ? const Icon(
                              Icons.visibility_off,
                              color: kBlack6,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: kBlack6,
                            ),
                    ),
                    labelText: 'Masukkan Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerKonfirmasiPassword,
                  obscureText: _showPassword2,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: togglePasswordVisibility2,
                        child: _showPassword2
                            ? const Icon(
                                Icons.visibility_off,
                                color: kBlack6,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: kBlack6,
                              ),
                      ),
                      hintText: 'Konfirmasi Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkap";
                    } else if (value != _controllerPassword.text) {
                      return "Password Salah";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kGreen2)),
        onPressed: addDataToFirebase,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.95,
          height: 40,
          child: const Center(
            child: Text("Submit"),
          ),
        ));
  }
}
