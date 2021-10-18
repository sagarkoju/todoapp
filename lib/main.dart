import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todoapp/Page/todo_profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Directory  directory= await getApplicationDocumentsDirectory();
 Hive.init(directory.path);
 // The first thing we do is to open a box we desire to store/fetch values from.
// initialze the Hive
  // Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<String>(
      "friends"); // creating a box    <string> type of data that we stored in the box // friend is the name of the box or variable that are use in the future
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoProfilePage(),
    );
  }
}
