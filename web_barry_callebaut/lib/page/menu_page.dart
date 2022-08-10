import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_barry_callebaut/page/petani/petani_page.dart';
import 'package:web_barry_callebaut/theme/colors.dart';

import '../theme/padding.dart';
import 'dashboard_page.dart';
import 'koordinator/koordinator_page.dart';
import 'petugas/petugas_page.dart';

final _availablePages = <String, WidgetBuilder>{
  'Dashboard': (_) => const DashboardPage(),
  'Data Koordinator': (_) => const KoordinatorPage(),
  'Data Petugas': (_) => const PetugasPage(),
  'Data Petani': (_) => const PetaniPage()
};

void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
  if (ref.read(selectedPageNameProvider.state).state != pageName) {
    ref.read(selectedPageNameProvider.state).state = pageName;
  }
}

final selectedPageNameProvider = StateProvider<String>((ref) {
  return _availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageNameProvider.state).state;
  return _availablePages[selectedPageKey]!;
});

class MenuPage extends ConsumerWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider.state).state;
    return Scaffold(
      backgroundColor: kGreen2,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset("assets/logo.svg", width: 36,),
            const SizedBox(width: 8,),
            const Text("Barry Callebaut")
          ],
        ),
        backgroundColor: darkGreen,
      ),
      body: Column(
        children: [
          GetAdmin(name: _name.toString(), email: _email.toString()),
          Expanded(
            child: ListView(
              children: <Widget>[
                for (var pageName in _availablePages.keys)
                  PageListTile(
                    selectedPageName: selectedPageName,
                    pageName: pageName,
                    onPressed: () => _selectPage(context, ref, pageName),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageListTile extends StatelessWidget {
  const PageListTile({
    Key? key,
    this.selectedPageName,
    required this.pageName,
    this.onPressed,
  }) : super(key: key);
  final String? selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Opacity(
        opacity: selectedPageName == pageName ? 1.0 : 0.0,
        child: const Icon(
          Icons.check,
          color: kWhite,
        ),
      ),
      title: Text(
        pageName,
        style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
      ),
      onTap: onPressed,
    );
  }
}

String? _uid;
String? _name;
String? _email;

class GetAdmin extends StatefulWidget {
  final String name;
  final String email;
  const GetAdmin({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<GetAdmin> createState() => _GetAdminState();
}

class _GetAdminState extends State<GetAdmin> {

  Future<dynamic> getAdmin() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          _uid = result.docs[0].data()['uid'];
          _name = result.docs[0].data()['username'];
          _email = result.docs[0].data()['email'];
        });
      }
    });
  }

  @override
  void initState() {
    getAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding),
      child: Column(
        children: [
          SvgPicture.asset("assets/admin.svg", width: 72,),
          const SizedBox(height: 12,),
          Text("$_name", style: const TextStyle(color: kWhite, fontSize: 16),), 
          const SizedBox(height: 4),
          Text("$_email", style: const TextStyle(color: kWhite),),
          const SizedBox(height: 12,),
          const Divider(thickness: 0.1, color: kWhite,)
        ],
      ),
    );
  }
}