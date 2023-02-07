import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String name;
  String profileImage;
  String email;
  String uid;

  MyUser({
    required this.name,
    required this.profileImage,
    required this.email,
    required this.uid,
});
  Map<String, dynamic> toJson(){
    return {
      "name" : name,
      "profileImage" : profileImage,
      "email" : email,
      "uid" : uid,
    };

  }
  static MyUser fromSnap( DocumentSnapshot snapshot){
    var snap = snapshot.data() as Map<String , dynamic>;
    return MyUser(
      email: snap['email'],
      profileImage: snap['profileImage'],
      uid: snap['uid'],
      name: snap['name'],
    );
  }
}