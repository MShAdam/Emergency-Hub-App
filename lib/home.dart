import 'dart:io';
import 'package:emergancyhub/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int notifyNumber = 0;

  File? _imageFile;
  final String? userId = global.user_key; // Replace with your actual user ID
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child("users");

  @override
  void initState() {
    super.initState();
    fetchDataOnce();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> fetchDataOnce() async {
    try {
      await Firebase.initializeApp();
      final database = FirebaseDatabase.instance;
      final reference =
          database.ref('/requests'); // Replace with your path and key

      final snapshot = await reference.once();
      if (snapshot.snapshot.exists) {
        final data =
            snapshot.snapshot.value as Map<dynamic, dynamic>; // Cast to Map
        for (var key in data.keys) {
          var req = data[key];
          for (var reqData in req.values) {
            if (reqData.containsKey("userkey")) {
              if (reqData['userkey'] == global.user_key) {
                if (reqData['notifapp']) {
                  notifyNumber++;
                }
              }
            }
          }
        }
      } else {
        print('No data available');
      }
    } catch (error) {
      print('Error fetching data: $error');
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
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.05,
                        // ),
                        const Align(
                          alignment: Alignment(-0.8, -1.0),
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  StreamBuilder<DatabaseEvent>(
                                    stream: _database.child(userId!).onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }
                                      var userDoc = (snapshot.hasData &&
                                              snapshot.data!.snapshot.value !=
                                                  null)
                                          ? snapshot.data!.snapshot.value as Map
                                          : {};
                                      var imageUrl = (userDoc.isNotEmpty)
                                          ? userDoc['profileImageUrl']
                                          : "";
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: imageUrl != null
                                                ? NetworkImage(imageUrl)
                                                : null,
                                            child: imageUrl == null
                                                ? Icon(Icons.person, size: 50)
                                                : null,
                                          ),
                                          Positioned(
                                            bottom: -10,
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushNamed("/profile");
                                              },
                                              tooltip: 'Upload Image',
                                            ),
                                          ),
                                          // const Positioned(
                                          //   top: 0,
                                          //   child: Text(
                                          //     "My Profile",
                                          //   ),
                                          // ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/history');
                                },
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                  size: 20.0,
                                ),
                                label: Text(notifyNumber.toString()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
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
                                onPressed: () {
                                  Navigator.pushNamed(context, '/bloodRequest');
                                },
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
                                  8.0, 15.0, 10.0, 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'I can Help You\nand fix your problem', // Replace with your text
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/img/bottom_img.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: const Alignment(-0.8, -1.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    fixedSize: const Size(200, 48)),
                                child: const Text(
                                  'Contact Us: +201234321345',
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
