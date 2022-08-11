import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_barry_callebaut/utils/constant.dart';

import '../../enum/enum.dart';
import '../../theme/colors.dart';
import '../../theme/padding.dart';

class UpdatePetaniPage extends StatefulWidget {
  final bool isEdit;
  final String docId;
  final String namaLengkap;
  final String nomorHp;
  final String tanggalLahir;
  final String statusNikah;
  final String kelompok;
  final String alamat;
  final String dusun;
  final String desaKelurahan;
  final String kecamatan;
  final String kabupaten;
  final String jekel;
  const UpdatePetaniPage(
      {Key? key,
      required this.isEdit,
      required this.docId,
      this.namaLengkap = '',
      this.nomorHp= '',
      this.tanggalLahir= '',
      this.statusNikah = '',
      this.kelompok = '',
      this.alamat = '',
      this.dusun = '',
      this.desaKelurahan = '',
      this.kecamatan = '',
      this.kabupaten = '',
      this.jekel = ''})
      : super(key: key);

  @override
  State<UpdatePetaniPage> createState() => _UpdatePetaniPageState();
}

class _UpdatePetaniPageState extends State<UpdatePetaniPage> {
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

  updateData() async {
    if (widget.isEdit) {
      DocumentReference document = FirebaseFirestore.instance
          .collection(collectionPetani)
          .doc(widget.docId);

      return FirebaseFirestore.instance
          .runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(document);

            if (!snapshot.exists) {
              throw Exception('Pengguna tidak ada!');
            }

            transaction.update(document, <String, dynamic>{
              'docId': widget.docId,
              'nama lengkap': _controllerNamaLengkap.text,
              'nomor hp': _controllerNoHp.text,
              'tanggal lahir': _controllerTglLahir.text,
              'status pernikahan': _controllerStatusNikah.text,
              'kelompok': _controllerKelompok.text,
              'alamat': _controllerAlamat.text,
              'dusun': _controllerDusun.text,
              'desa/kelurahan': _controllerDesaKelurahan.text,
              'kecamatan': _controllerKecamatan.text,
              'kabupaten': _controllerKabupaten.text,
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
      _controllerNamaLengkap.text = widget.namaLengkap;
      _controllerNoHp.text = widget.nomorHp;
      _controllerTglLahir.text = widget.tanggalLahir;
      _controllerStatusNikah.text = widget.statusNikah;
      _controllerKelompok.text = widget.kelompok;
      _controllerAlamat.text = widget.alamat;
      _controllerDusun.text = widget.dusun;
      _controllerDesaKelurahan.text = widget.desaKelurahan;
      _controllerKecamatan.text = widget.kecamatan;
      _controllerKabupaten.text = widget.kabupaten;
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
                const SizedBox(height: 24,),
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
