import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/friends_page.dart';
import 'package:flutter_app_practice_online/store/friends.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ChangeNotifierProvider(
        builder: (context) => Friends(),
        child: FriendsPage(),
      ),
    );
  }
}
