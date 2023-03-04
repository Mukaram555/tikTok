import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String name;
  String profilePic;
  String email;
  String uid;

  MyUser({
    required this.name,
    required this.profilePic,
    required this.email,
    required this.uid,
});
  Map<String, dynamic> toJson(){
    return {
      "name" : name,
      "profilePic" : profilePic,
      "email" : email,
      "uid" : uid,
    };

  }
  static MyUser fromSnap( DocumentSnapshot snapshot){
    var snap = snapshot.data() as Map<String , dynamic>;
    return MyUser(
      email: snap['email'],
      profilePic: snap['profilePic'],
      uid: snap['uid'],
      name: snap['name'],
    );
  }
}