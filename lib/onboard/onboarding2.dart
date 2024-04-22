import 'package:flutter/material.dart';
import 'package:emergancyhub/onboard/Onboarding3.dart';

class onboard2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0530,
                        ),
                        Image.asset(
                          'assets/img/blood-drive-icon 1.png',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.085,
                        ),
                        const Text(
                          "REQUEST BLOOD and DONATE BLOOD",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        const Text(
                          "Use the network on emergency hub to request blood from anyone, anywhere by sending out a broadcast.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/onboard3Screen');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,),
                          child: const Text(
                            'Skip Tour',
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
