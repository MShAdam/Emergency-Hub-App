// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class MyData {
//   final String name;
//   final String address;
//   final String age;
//   final String gender;
//   final String phone;

//   MyData({
//     required this.name,
//     required this.address,
//     required this.age,
//     required this.gender,
//     required this.phone,
//   });

//   factory MyData.fromSnapshot(final snapshot) {
//     // Add breakpoint here to inspect data retrieved from Firebase
//     debugger; // This line will pause execution when reached
//     final data = snapshot.value as Map<dynamic, dynamic>;
//     return MyData(
//       name: data["name"] ?? "",
//       address: data["address"] ?? "",
//       age: data["age"] ?? "",
//       gender: data["gender"] ?? "",
//       phone: data["phone"] ?? "",
//     );
//   }
// }

// class FirebaseDataPage extends StatefulWidget {
//   @override
//   _FirebaseDataPageState createState() => _FirebaseDataPageState();
// }

// class _FirebaseDataPageState extends State<FirebaseDataPage> {
//   late DatabaseReference _databaseReference;
//   late List<MyData> dataList = [];

//   @override
//   void initState() {
//     super.initState();
//     _databaseReference =
//         FirebaseDatabase.instance.reference().child("ambulance");
//     _databaseReference.onChildAdded.listen(_onEntryAdded);
//   }

//   _onEntryAdded(Event event) {
//     // Add breakpoint here to inspect newly added data
//     debugger;

//     setState(() {
//       dataList.add(MyData.fromSnapshot(event.snapshot));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Data'),
//       ),
//       body: ListView.builder(
//         itemCount: dataList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             child: ListTile(
//               title: Text(dataList[index].name),
//               subtitle: Text(dataList[index].address),
//               trailing: Text(dataList[index].phone),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Firebase Demo',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: FirebaseDataPage(),
//   ));
// }
