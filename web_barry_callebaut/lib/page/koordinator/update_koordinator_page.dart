import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:web_barry_callebaut/utils/constant.dart';

import '../../enum/enum.dart';
import '../../theme/colors.dart';
import '../../theme/padding.dart';

class UpdateKoordinatorPage extends StatefulWidget {
  final bool isEdit;
  final String uid;
  final String idNumber;
  final String username;
  final String namaLengkap;
  final String nik;
  final String nomorHp;
  final String tglLahir;
  final String lokasiKerja;
  final String jekel;
  final String email;
  final String alamat;
  final String agama;
  const UpdateKoordinatorPage(
      {Key? key,
      required this.isEdit,
      required this.uid,
      this.idNumber = '',
      this.username = '',
      this.namaLengkap = '',
      this.nik = '',
      this.nomorHp = '',
      this.tglLahir = '',
      this.lokasiKerja = '',
      this.jekel = '',
      this.email = '',
      this.alamat = '',
      this.agama = ''})
      : super(key: key);

  @override
  State<UpdateKoordinatorPage> createState() => _UpdateKoordinatorPageState();
}

class _UpdateKoordinatorPageState extends State<UpdateKoordinatorPage> {
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

  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerNamaLengkap = TextEditingController();
  final TextEditingController _controllerNik = TextEditingController();
  final TextEditingController _controllerNoHp = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerLokasiKerja = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
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

  updateData() async {
    if (widget.isEdit) {
      DocumentReference document = FirebaseFirestore.instance
          .collection(collectionKoordinator)
          .doc(widget.uid);

      return FirebaseFirestore.instance
          .runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(document);

            if (!snapshot.exists) {
              throw Exception('Pengguna tidak ada!');
            }

            transaction.update(document, <String, dynamic>{
              'uid': widget.uid,
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
            });
          })
          .then((value) => Future.delayed(const Duration(seconds: 3), () {
                showDialog(
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
                            Text("Data berhasil di update!"),
                          ],
                        ),
                      );
                    });
              }))
          .catchError((error) => Future.delayed(const Duration(seconds: 3), () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.close,
                              size: 60,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Gagal di update!"),
                          ],
                        ),
                      );
                    });
              }));
    }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      _controllerIdNumber.text = widget.idNumber;
      _controllerUsername.text = widget.username;
      _controllerNamaLengkap.text = widget.namaLengkap;
      _controllerNik.text = widget.nik;
      _controllerNoHp.text = widget.nomorHp;
      _controllerTglLahir.text = widget.tglLahir;
      _controllerLokasiKerja.text = widget.lokasiKerja;
      _controllerEmail.text = widget.email;
      _controllerAlamat.text = widget.alamat;
      _selectAgama = widget.agama;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(padding),
        child: formDetail(),
      ),
    );
  }

  Widget formDetail() {
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
                const SizedBox(
                  height: 24,
                ),
                buttonUpdate()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonUpdate() {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kGreen2)),
        onPressed: updateData,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.95,
          height: 40,
          child: const Center(
            child: Text("Update"),
          ),
        ));
  }
}
