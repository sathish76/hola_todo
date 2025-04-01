import 'package:flutter/material.dart';
import 'package:hola_todo/app.dart';
import 'package:hola_todo/core/di/di.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
