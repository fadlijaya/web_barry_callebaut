import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_barry_callebaut/utils/constant.dart';

import '../login_view.dart';
import '../theme/colors.dart';
import '../theme/padding.dart';

final Stream<QuerySnapshot> _streamKoordinator =
    FirebaseFirestore.instance.collection("koordinator").snapshots();

final Stream<QuerySnapshot> _streamPetugas =
    FirebaseFirestore.instance.collection("petugas").snapshots();

final Stream<QuerySnapshot> _streamPetani =
    FirebaseFirestore.instance.collection("petani").snapshots();

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _uid;
  String? _username;
  String? _email;

  @override
  void initState() {
    getAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kGrey,
      appBar: AppBar(
        backgroundColor: darkGreen,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: logout,
              icon: const Icon(
                Icons.exit_to_app,
                color: kGreen2,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            titlePage(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.4,
                children: [
                  cardKoordinator(),
                  cardPetugas(),
                  cardPetani()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titlePage() {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.only(left: 24, top: 24),
      child: const Text(titleDashboard,
          style: TextStyle(
              color: darkGreen, fontWeight: FontWeight.bold, fontSize: 30)),
    );
  }

  Widget cardKoordinator() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamKoordinator,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error!"),
            );
          } else {
            int totalData = snapshot.data!.docs.length;
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    padding: EdgeInsets.all(padding),
                    decoration: const BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/koordinator.svg",
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            "${int.parse(totalData.toString())}", //dashboardModel.totalProduct.toString(),
                            style: const TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                                color: kWhite),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Koordinator',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget cardPetugas() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamPetugas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error!"),
            );
          } else {
            int totalData = snapshot.data!.docs.length;
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    padding: const EdgeInsets.all(padding),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/petugas.svg",
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            "${int.parse(totalData.toString())}",
                            style: const TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                                color: kWhite),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Petugas',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
                ],
              ),
            );
          }
        });
  }

  Widget cardPetani() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamPetani,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error!"),
            );
          } else {
            int totalData = snapshot.data!.docs.length;
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    padding: const EdgeInsets.all(padding),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "assets/petani.svg",
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            "${int.parse(totalData.toString())}",
                            style: const TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                                color: kWhite),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Petani',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
                ],
              ),
            );
          }
        });
  }


  Future getAdmin() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          _uid = result.docs[0].data()['uid'];
          _username = result.docs[0].data()['username'];
          _email = result.docs[0].data()['email'];
        });
      }
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut().then((_) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false));
  }
}
