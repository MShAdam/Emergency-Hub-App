import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/globals.dart' as global;

class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<Map<dynamic, dynamic>> history = [];

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History'),
      ),
      body: ListView.builder(
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
            title: Text(history[index]["key"]!),
            subtitle: Text(message),
            // subtitle: Text(history[index]["name"]!),
            onTap: () {
              // Handle tap on list item (if needed)
            },
          );
        },
      ),
    );
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
