import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_barry_callebaut/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_barry_callebaut/page/koordinator/koordinator_page.dart';
import 'package:web_barry_callebaut/theme/material_colors.dart';

import 'options/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: apiKey, 
      appId: appId, 
      messagingSenderId: messagingSenderId, 
      projectId: projectId)
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barry Callebaut',
      theme: ThemeData(primarySwatch: colorGreens, fontFamily: 'Poppins'),
      home: const LoginView(),
    );
  }
}
