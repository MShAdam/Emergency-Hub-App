import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;
import 'package:intl/intl.dart' as intl;

class historyScreen extends StatefulWidget {
  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<Map<dynamic, dynamic>> history = [];
  late String date = '';
  late String Time = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch data when the page initializes
    fetchDataOnce();
  }

  Future<void> fetchDataOnce() async {
    try {
      history = [];
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
          for (var reqKey in req.keys) {
            // print(key);
            var reqData = req[reqKey];
            if (reqData.containsKey("userkey")) {
              if (reqData['userkey'] == global.user_key) {
                Map<dynamic, dynamic> hist = reqData;
                hist['key'] = key;
                hist['reqkey'] = reqKey;
                hist['notifapp'] = reqData['notifapp'];
                hist['date'] = intl.DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(hist["reservationDate"]));
                hist['time'] = intl.DateFormat('hh:mm a')
                    .format(DateTime.parse(hist["reservationDate"]));
                history.add(hist);

                // print(hist);
              }
            }
            // print(reqData);
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

  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  void _updateNotifApp(String path) {
    _database.child(path).update({
      'notifapp': false,
    }).then((_) {
      print('Notification app status updated to false');
    }).catchError((error) {
      print('Failed to update notification app status: $error');
    });
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
                              0.9, // Adjust height as needed
                          child: ListView.builder(
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              String Status = '';
                              if (history[index]["accepted"]) {
                                Status = "accepted";
                              } else if (history[index]["removed"]) {
                                Status = "Refused";
                              } else {
                                Status = 'N\\A';
                              }
                              String message = """
                    Date: ${history[index]["date"]}
                    Time: ${history[index]["time"]}
                    Patient Name: ${history[index]["name"]}
                    Patient Phone: ${history[index]["phone"]}
                    Patient age: ${history[index]["age"]}
                    Patient room: ${history[index]["room"]}
                    Request Status: $Status
                                """;
                              var titleColor = AppColors.textColor;
                              if (history[index]["notifapp"]) {
                                titleColor =
                                    const Color.fromARGB(255, 255, 64, 70);
                              }
                              return ListTile(
                                title: Text(history[index]["key"]!,
                                    style: TextStyle(
                                        // Apply text style for title
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: titleColor)),
                                subtitle: Text(message,
                                    style: TextStyle(
                                        // Apply text style for title
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor)),
                                onTap: () {
                                  // Handle tap on list item (if needed)
                                  _updateNotifApp('/requests/' +
                                      history[index]["key"] +
                                      '/' +
                                      history[index]["reqkey"]);
                                  Navigator.pushReplacementNamed(
                                      context, '/history');
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001,
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
