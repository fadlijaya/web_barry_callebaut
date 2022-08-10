import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_barry_callebaut/page/petugas/create_petugas_page.dart';
import 'package:web_barry_callebaut/theme/colors.dart';
import 'package:web_barry_callebaut/utils/constant.dart';

import '../../theme/padding.dart';
import 'update_petugas_page.dart';

final Stream<QuerySnapshot> _streamPetugas =
    FirebaseFirestore.instance.collection(collectionPetugas).snapshots();

class PetugasPage extends StatefulWidget {
  const PetugasPage({Key? key}) : super(key: key);

  @override
  _PetugasPageState createState() => _PetugasPageState();
}

class _PetugasPageState extends State<PetugasPage> {
  showDataDetail(uid, idNumber, username, namaLengkap, nik, noHp, tglLahir,
      lokasiKerja, jekel, email, alamat, agama) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "UID",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$uid',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Username",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$username',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$email',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Nama Lengkap",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$namaLengkap',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Lokasi Kerja",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$lokasiKerja',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Nomor HP",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$noHp',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Alamat",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$alamat',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Agama",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$agama',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$jekel',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "NIK",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$nik',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tempat Tanggal Lahir",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '$tglLahir',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }

  statusDelete() {
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
                Text("Data berhasil di hapus!"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    return Scaffold(
      backgroundColor: kGrey,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: [titleHeader(), buttonAddData(), itemList()],
          )),
    );
  }

  Widget titleHeader() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      child: const Text(
        titlePetugas,
        style: TextStyle(
            fontSize: 30, color: darkGreen, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buttonAddData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 24, bottom: 12),
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: kOrange),
          child: TextButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePetugasPage())),
              icon: const Icon(
                Icons.add,
                color: kWhite,
              ),
              label: const Text(
                "Tambah Data",
                style: TextStyle(color: kWhite),
              )),
        ),
      ],
    );
  }

  Widget itemList() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        height: 540,
        padding: const EdgeInsets.all(padding),
        child: StreamBuilder<QuerySnapshot>(
            stream: _streamPetugas,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error!'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "Belum Ada Data!",
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: const [
                          Text(
                            "UID",
                            style: TextStyle(color: kGreen),
                          ),
                          SizedBox(
                            width: 260,
                          ),
                          Text(
                            "ID Number",
                            style: TextStyle(color: kGreen),
                          ),
                          SizedBox(
                            width: 116,
                          ),
                          Text(
                            "Username",
                            style: TextStyle(color: kGreen),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          Text(
                            "Nama Lengkap",
                            style: TextStyle(color: kGreen),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        return Container(
                          width: double.infinity,
                          height: 40,
                          color: kGrey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 880,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Text(data['uid']),
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      Text(data['idNumber']),
                                      const SizedBox(
                                        width: 120,
                                      ),
                                      Text(data['username']),
                                      const SizedBox(
                                        width: 120,
                                      ),
                                      Text(data['nama lengkap']),
                                    ],
                                  )),
                              Expanded(
                                  child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => showDataDetail(
                                        data['uid'],
                                        data['idNumber'],
                                        data['username'],
                                        data['nama lengkap'],
                                        data['nik'],
                                        data['nomor hp'],
                                        data['tanggal lahir'],
                                        data['lokasi kerja'],
                                        data['jenis kelamin'],
                                        data['email'],
                                        data['alamat'],
                                        data['agama']),
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: kGreen2,
                                      size: 16,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdatePetugasPage(
                                              isEdit: true,
                                              uid: data['uid'],
                                              idNumber: data['idNumber'],
                                              username: data['username'],
                                              namaLengkap: data['nama lengkap'],
                                              nik: data['nik'],
                                              nomorHp: data['nomor hp'],
                                              tglLahir: data['tanggal lahir'],
                                              lokasiKerja: data['lokasi kerja'],
                                              jekel: data['jenis kelamin'],
                                              email: data['email'],
                                              alamat: data['alamat'],
                                              agama: data['agama'],
                                            ),
                                          )),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: kGreen2,
                                        size: 16,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    "Yakin ingin menghapus data ${data['nama lengkap']}?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text(
                                                        "Batal",
                                                        style: TextStyle(
                                                            color: kBlack),
                                                      )),
                                                  TextButton(
                                                      onPressed: () async {
                                                        document.reference
                                                            .delete();
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                collectionPetugas)
                                                            .doc(document.id)
                                                            .delete()
                                                            .then((value) =>
                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                                    () {
                                                                  statusDelete();
                                                                }));
                                                      },
                                                      child: const Text(
                                                        "Hapus",
                                                        style: TextStyle(
                                                            color: kGreen2),
                                                      )),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 16,
                                      )),
                                ],
                              ))
                            ],
                          ),
                        );
                      }).toList()),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
