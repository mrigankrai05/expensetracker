import "package:flutter/material.dart";
import './expenseview.dart';

void main() {
  runApp(
    MaterialApp(
      home: Expenseview(),
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 146, 39, 39)),
    ),
  );
}
