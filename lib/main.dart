import 'package:flutter/material.dart';
import 'package:flutter_rest_apis_call/screens/ImagesHomeScreen.dart';
import 'package:flutter_rest_apis_call/screens/LoginSignupScreens/SignupScreen.dart';
import 'package:flutter_rest_apis_call/screens/ProductsApiScreen.dart';
import 'package:flutter_rest_apis_call/screens/UserApiScreen.dart';
import 'package:flutter_rest_apis_call/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignupScreen()
    );
  }
}
