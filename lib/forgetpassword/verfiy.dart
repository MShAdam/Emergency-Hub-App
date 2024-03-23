import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/forgetpassword/forgetpassword.dart';

class verfiyPasswordScreen extends StatefulWidget {
  const verfiyPasswordScreen({super.key});

  @override
  State<verfiyPasswordScreen> createState() => _verfiyPasswordScreenState();
}

class _verfiyPasswordScreenState extends State<verfiyPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  bool codeVerfication = false;
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String code = "";
      for (TextEditingController controller in _controllers) {
        code = code + controller.text;
      }
      if (code == "9876") {
        codeVerfication = true;
      }
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
                                      return ForgetPasswordScreen();
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
                              "Enter Verification Code",
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
                              "Enter code that we have sent to your Email* ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) {
                              return SizedBox(
                                width: 50,
                                child: TextFormField(
                                  controller: _controllers[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onChanged: (String value) {
                                    if (value.length == 1 && index < 3) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter verification code';
                                    }
                                    return null;
                                  },
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _submitForm(context);
                              if (codeVerfication) {
                                Navigator.pushReplacementNamed(
                                    context, '/changepassword');
                                // Show success message or navigate to password reset page
                              } else {
                                // Show error message: Email does not exist
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Invalid Code.'),
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
                              'Verify',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn’t receive the code? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return verfiyPasswordScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Resend",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
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
