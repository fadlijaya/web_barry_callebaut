import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enum/enum.dart';
import '../../theme/colors.dart';
import '../../theme/padding.dart';
import '../../utils/constant.dart';

class CreatePetaniPage extends StatefulWidget {
  const CreatePetaniPage({Key? key}) : super(key: key);

  @override
  State<CreatePetaniPage> createState() => _CreatePetaniPageState();
}

class _CreatePetaniPageState extends State<CreatePetaniPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();
  JenisKelamin? _jekel = JenisKelamin.pria;

  final TextEditingController _controllerNamaLengkap = TextEditingController();
  final TextEditingController _controllerNoHp = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerStatusNikah = TextEditingController();
  final TextEditingController _controllerKelompok = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerDusun = TextEditingController();
  final TextEditingController _controllerDesaKelurahan = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();

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
        final docId = FirebaseFirestore.instance
        .collection(collectionPetani)
        .doc()
        .id;

        await FirebaseFirestore.instance
            .collection(collectionPetani)
            .doc(docId)
            .set({
          'docId': docId,
          'nama lengkap': _controllerNamaLengkap.text,
          'nomor hp': _controllerNoHp.text,
          'tanggal lahir': _controllerTglLahir.text,
          'status pernikahan': _controllerStatusNikah.text,
          'kelompok': _controllerKelompok.text,
          'alamat': _controllerAlamat.text,
          'dusun': _controllerDusun.text,
          'desa_kelurahan': _controllerDesaKelurahan.text,
          'kecamatan': _controllerKecamatan.text,
          'kabupaten': _controllerKabupaten.text,
          'jenis kelamin': _jekel.toString(),
          'status ditambahkan': false
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
    _controllerNamaLengkap.clear();
    _controllerNoHp.clear();
    _controllerTglLahir.clear();
    _controllerStatusNikah.clear();
    _controllerKelompok.clear();
    _controllerAlamat.clear();
    _controllerDusun.clear();
    _controllerDesaKelurahan.clear();
    _controllerKecamatan.clear();
    _controllerKabupaten.clear();
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
                  controller: _controllerStatusNikah,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Status Nikah'),
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
                TextFormField(
                  controller: _controllerKelompok,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Kelompok'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: _controllerDusun,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Dusun'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerDesaKelurahan,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Desa/Kelurahan'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerKecamatan,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Kecamatan'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerKabupaten,
                  textInputAction: TextInputAction.done,
                  decoration:
                      const InputDecoration(labelText: 'Masukkan Kabupaten'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mohon dilengkapi";
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
