import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;

class historyScreen extends StatefulWidget {
  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<Map<dynamic, dynamic>> history = [];
  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the page initializes
    fetchDataOnce();
  }

  Future<void> fetchDataOnce() async {
    try {
      await Firebase.initializeApp();
      final database = FirebaseDatabase.instance;
      // while (!global.loggedin) {
      //   await Future.delayed(Duration(seconds: 1));
      // }

      final reference =
          database.ref('/requests'); // Replace with your path and key

      final snapshot = await reference.once();
      if (snapshot.snapshot.exists) {
        final data =
            snapshot.snapshot.value as Map<dynamic, dynamic>; // Cast to Map
        for (var key in data.keys) {
          var req = data[key];
          for (var reqData in req.values) {
            print(key);
            if (reqData.containsKey("userkey")) {
              if (reqData['userkey'] == global.user_key) {
                Map<dynamic, dynamic> hist = reqData;
                hist['key'] = key;
                history.add(hist);
                print(hist);
              }
            }
            print(reqData);
          }
        }
        print("history: $history");

        setState(() {
          // _phone = data['phone'] ?? _phone; // Update age if available
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.5, // Adjust height as needed
                          child: ListView.builder(
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              String Status = '';
                              if (history[index]["accepted"]) {
                                Status = "accepted";
                              } else if (history[index]["removed"]) {
                                Status = "Refused";
                              }
                              String message = """
                    Pationt Name: ${history[index]["name"]}
                    Pationt Phone: ${history[index]["phone"]}
                    Pationt age: ${history[index]["age"]}
                    Pationt room: ${history[index]["room"]}
                    Request Status: $Status
                                """;
                              return ListTile(
                                title: Text(history[index]["key"]!,
                                    style: TextStyle(
                                      // Apply text style for title
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor
                                    )),
                                subtitle: Text(message,
                                    style: TextStyle(
                                      // Apply text style for title
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor
                                    )),
                                onTap: () {
                                  // Handle tap on list item (if needed)
                                },
                              );
                            },
                          ),
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
