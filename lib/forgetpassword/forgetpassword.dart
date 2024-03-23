import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergancyhub/signin.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool _emailExists = false;

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      _emailExists = true;
      print('Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for the provided email.');
        // Handle user not found error (e.g., show a message to the user)
      } else {
        print(e.message);
        // Handle other Firebase errors (e.g., network issues)
      }
    }
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> _checkEmailExists(String email) async {
  //   try {
  //     List<String> signInMethods =
  //         await _auth.fetchSignInMethodsForEmail(email);
  //     if (signInMethods.isNotEmpty) {
  //       setState(() {
  //         _emailExists = true;
  //       });
  //     } else {
  //       setState(() {
  //         _emailExists = false;
  //       });
  //     }
  //   } catch (e) {
  //     print("Error checking email: $e");
  //   }
  // }

  // Future<void> _resetPassword(String email) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: email);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Password reset email sent'),
  //       ),
  //     );
  //   } catch (e) {
  //     print("Error sending reset email: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error sending reset email'),
  //       ),
  //     );
  //   }
  // }

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
                                    fontSize: 25),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          const Align(
                            alignment: Alignment(-1, -0.5),
                            child: Text(
                              "Forgot Your Password?",
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
                              "Enter your email , we will send you confirmation code",
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
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(
                                LoginIcon.email,
                                color: AppColors.text2_Color,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!(value.contains("@") &&
                                  value.contains(".") &&
                                  value.length > 8)) {
                                return "Email Not Valid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              String email = _emailController.text.trim();
                              await sendPasswordResetEmail(email);
                              if (_emailExists) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Info'),
                                      content:
                                          Text('Password reset email sent!'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, '/signin');
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Show success message or navigate to password reset page
                              } else {
                                // Show error message: Email does not exist
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Email does not exist.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 48)),
                            child: const Text(
                              'Reset Password',
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
