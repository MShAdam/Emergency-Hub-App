import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the page initializes
    fetchDataOnce();
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
                                  Navigator.pushNamed(context, '/home');
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
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/emergency-hub-e6079.appspot.com/o/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png?alt=media&token=08682b5a-3b87-4f63-a550-52a6cd021905'),
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
                            Navigator.pushReplacementNamed(context, '/history');
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
