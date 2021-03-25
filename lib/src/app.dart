import 'package:flutter/material.dart';
import 'package:instagram_clone/src/screens/LoginScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      // onGenerateRoute: appRoutes.routes,
      home: LoginScreen(), // insta_home.dart from screens package
    );
  }
}
