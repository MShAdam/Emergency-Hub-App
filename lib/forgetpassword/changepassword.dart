 import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/signin.dart';

class ChangePasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Align(
                            alignment: const Alignment(-1.19, -1),
                            child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SigninScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "<",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 25
                              ),
                            ),
                          ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          const Align(
                            alignment: Alignment(-1, -0.5),
                            child: Text(
                              "Create New Password",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0090,
                          ),
                          const Align(
                            alignment: Alignment(-0.7, -0.5),
                            child: Text(
                              "Create your new password to login",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(
                                LoginIcon.lock,
                                color: Color.fromARGB(255, 1, 1, 1),
                              ),
                              suffixIcon: const Icon(LoginIcon.visibility),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _repasswordController,
                            decoration: InputDecoration(
                              hintText: "Conform Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(
                                LoginIcon.lock,
                                color: Color.fromARGB(255, 1, 1, 1),
                              ),
                              suffixIcon: const Icon(LoginIcon.visibility),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value != _passwordController.text) {
                                return 'passwords are not matched.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _submitForm(context),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 48)),
                            child: const Text(
                              'Create Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
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
