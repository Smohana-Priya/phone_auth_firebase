import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyAe-JZzTvkp0siiXmFd6Ak2LfWZNbSSrYI",
            appId: "1:472362730743:android:85607f51f6201d52bcbff2",
            messagingSenderId: "472362730743",
            projectId: "loginwithfirebase-b6210",
          ),
        )
      : Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}
