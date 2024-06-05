import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergancyhub/signup.dart';
import 'package:emergancyhub/onboard/splashscreen.dart';
import 'package:emergancyhub/profile/profile.dart';
import 'package:emergancyhub/globals.dart' as global;

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        _getUserByEmail(_emailController.text.trim());

        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error: $e');
      }
    }
  }

  final _database = FirebaseDatabase.instance; // Initialize Firebase Database

  Future _getUserByEmail(String email) async {
    try {
      final usersRef = _database.ref('/users');
      final snapshot =
          await usersRef.orderByChild('email').equalTo(email).once();
      if (snapshot.snapshot.exists) {
        global.user_key = snapshot.snapshot.children.first.key;
        global.loggedin = true;
      } else {
        return null; // No user found
      }
    } catch (error) {
      print(error); // Handle potential errors here
      return null;
    }
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.white, //FCFCFE
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Image.asset('assets/img/headimg.jpg'),
                              Positioned(
                                right: 10.0,
                                top: 25.0,
                                child: Image.asset(
                                    'assets/img/logo.png'), // Your foreground image
                              ),
                            ],
                          ),

                          /////////////////////////////////////
                          /////////////////////////////////////
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}

class AppColors {
  static const primaryColor = Color(0xff40bfff);
  static const textColor = Color(0xff223263);
  static const text2_Color = Color(0xff9098B1);
  static const DiscountColor = Color(0xffFB7181);
  static const borderColor = Color(0xffEBF0FF);
  static const ngmaColor = Color(0xffFFC833);
  static const WhiteColor = Colors.white;
}

class LoginIcon {
  static const email = Icons.email;
  static const lock = Icons.lock_outline;
  static const visibility = Icons.visibility_outlined;
  static const account = Icons.account_box_outlined;
  static const phone = Icons.phone;
}
