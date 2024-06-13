import 'package:emergancyhub/profile/history.dart';
import 'package:emergancyhub/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final String? userId = global.user_key; // Replace with your actual user ID
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child("users");

  String _username = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the page initializes
    fetchDataOnce();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      String fileName = 'profile_$userId.jpg';
      try {
        await _storage.ref('profile_images/$fileName').putFile(_imageFile!);
        String downloadUrl =
            await _storage.ref('profile_images/$fileName').getDownloadURL();
        await _database.child(userId!).update({'profileImageUrl': downloadUrl});
      } catch (e) {
        print(e);
      }
    }
  }

  // Function to fetch data from Firebase
  Future<void> fetchDataOnce() async {
    try {
      await Firebase.initializeApp();
      final database = FirebaseDatabase.instance;
      while (!global.loggedin) {
        await Future.delayed(Duration(seconds: 1));
      }
      final reference = database
          .ref('/users/${global.user_key}'); // Replace with your path and key

      final snapshot = await reference.once();
      if (snapshot.snapshot.exists) {
        final data =
            snapshot.snapshot.value as Map<dynamic, dynamic>; // Cast to Map
        String? key = snapshot.snapshot.key;
        String firstname = data['firstName'] ?? "";
        String lastname = data['lastName'] ?? "";
        setState(() {
          _username =
              firstname + " " + lastname; // Update username if available
          _email = data['email'] ?? _email; // Update email if available
          _phone = data['phone'] ?? _phone; // Update age if available
        });
      } else {
        print('No data available');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
                body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset('assets/img/headimg.jpg'),
                            Positioned(
                              right: 10.0,
                              top: 50.0,
                              child: Image.asset(
                                  'assets/img/logo.png'), // Your foreground image
                            ),
                            Positioned(
                              left: 10.0,
                              top: 50.0,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homeScreen()),
                                  );
                                  // Navigator.pushNamed(context, '/home');
                                },
                              ), // Your foreground image
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.85, // Ensures 85% width
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                if (snapshot.hasData &&
                                    snapshot.data!.snapshot.value != null) {
                                  var userDoc =
                                      snapshot.data!.snapshot.value as Map;
                                  var imageUrl = userDoc['profileImageUrl'];
                                  return Stack(
                                    // alignment: Alignment.center,
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
                                        right: -5,
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: _pickImage,
                                          tooltip: 'Upload Image',
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Stack(
                                    // alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        child: Icon(Icons.person, size: 50),
                                      ),
                                      Positioned(
                                        bottom: -10,
                                        right: -5,
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: _pickImage,
                                          tooltip: 'Upload Image',
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              '$_username',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_email',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_phone',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(context, '/history');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => historyScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.75,
                                  48)),
                          child: const Text(
                            'History',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signin');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.75,
                                  48)),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))));
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
  static const backgroundColor = Color(0xff0870A7);
}

class LoginIcon {
  static const email = Icons.email;
  static const lock = Icons.lock_outline;
  static const visibility = Icons.visibility_outlined;
  static const account = Icons.account_box_outlined;
  static const phone = Icons.phone;
}
