import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticktok/view/screens/add_video.dart';
import 'package:ticktok/view/screens/display_video.dart';
import 'package:ticktok/view/screens/search_screen.dart';

import '../view/screens/profile_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;


var pageIndex = [
  DisplayVideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Text('Message'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];


