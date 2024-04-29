import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Find your service",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              label: const Text('2'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.85, // Ensures 85% width
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              // Add borders
                              color: AppColors
                                  .primaryColor, // Change color as needed
                              width: 1.0, // Change border width as needed
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText:
                                        "Search doctor, drugs, articles...",
                                    hintStyle: TextStyle(
                                        color: AppColors.primaryColor),
                                    border: InputBorder
                                        .none, // Remove default border
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        const Align(
                          alignment: Alignment(-0.8, -1.0),
                          child: Text(
                            "Services",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/standardRooms');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/Standard rooms.png'), // Replace with your image path
                                    const Text(
                                      'Standard Rooms',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/intensiveCare');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/intensive care.png'), // Replace with your image path
                                    const Text(
                                      'Intensive Care',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/nursery');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/Nursery.png'), // Replace with your image path
                                    const Text(
                                      'Nursery',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/ambulance');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/Ambulance.png'), // Replace with your image path
                                    const Text(
                                      'Ambulance',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/Blood request.png'), // Replace with your image path
                                    const Text(
                                      'Blood Request',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/bloodDonation');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/Blood Donate.png'), // Replace with your image path
                                    const Text(
                                      'Blood Donate',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/quarantine');
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/img/quarantine.png'), // Replace with your image path
                                    const Text(
                                      'Quarantine',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0190,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(236, 243, 241, 1),
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 15.0, 8.0, 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'I can Help You\nand fix your problem', // Replace with your text
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 35),
                                    textAlign: TextAlign.left,
                                  ),
                                  Image.asset('assets/img/bottom_img.png'),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(-0.8, -1.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    fixedSize: Size(150, 48)),
                                child: const Text(
                                  'Contact Us ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                ),
                              ),
                            ),
                          ]),
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

class LoginIcon {
  static const email = Icons.email;
  static const lock = Icons.lock_outline;
  static const visibility = Icons.visibility_outlined;
  static const account = Icons.account_box_outlined;
  static const phone = Icons.phone;
}
