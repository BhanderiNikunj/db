import 'package:db/Screen/AddData/View/AddDataScreen.dart';
import 'package:db/Screen/Home/View/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/addData': (context) => AddDataScreen(),
      },
    ),
  );
}


List<Map> l1 = [];