import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Color(0xff232938),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}
