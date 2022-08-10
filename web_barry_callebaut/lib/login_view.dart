import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_barry_callebaut/theme/colors.dart';

import 'admin_view.dart';
import 'theme/padding.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  late bool _showPassword = true;
  late final bool _isLoading = false;

  @override
  void initState() {
     if (FirebaseAuth.instance.currentUser != null) {
       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const AdminView(),
          ),
          (route) => false,
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(child: image()),
            formLogin(),
          ],
        ),
      )),
    );
  }

  Widget image() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/logo.svg", width: 240,),
        header(),
      ],
    );
  }

  Widget header() {
    return Column(
      children: const [
        SizedBox(
          height: 16,
        ),
        Text(
          "Barry Callebaut",
          style: TextStyle(
              fontSize: 36, color: kBlack6, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget formLogin() {
    return Form(
        key: _formKey,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            width: 400,
            height: 400,
            padding: const EdgeInsets.all(padding),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: const [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: kBlack),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _controllerEmail,
                  cursorColor: kGreen2,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: kBlack6),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: kBlack6,
                      ),
                      hintText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: _showPassword,
                  cursorColor: kGreen2,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(color: kBlack6),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: kBlack6,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: togglePasswordVisibility,
                        child: _showPassword
                            ? const Icon(
                                Icons.visibility_off,
                                color: kBlack6,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: kBlack6,
                              ),
                      ),
                      hintText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                buttonLogin(),
              ],
            ),
          ),
        ));
  }

  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget buttonLogin() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kGreen2),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)))),
      onPressed: login,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        width: double.infinity,
        height: 48,
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(color: kWhite, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Future<dynamic> login() async {
    if (!_isLoading) {
      if (_formKey.currentState!.validate()) {
        if (_controllerEmail.text == "adminbc@gmail.com" &&
            _controllerPassword.text == "adminbc") {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassword.text);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AdminView()),
                (route) => false);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              displaySnackBar("Email Tidak Terdaftar");
            } else if (e.code == 'wrong-password') {
              displaySnackBar("Email/Password Salah");
            }
          }
        } else {
          displaySnackBar("Email/Password Salah!");
        }
      }
    }
  }

  displaySnackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}