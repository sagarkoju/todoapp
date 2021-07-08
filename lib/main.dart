import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:todoapp/Page/todo_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // initialze the Hive
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
