import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  String userName;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String id;

  Comment({
    required this.userName,
    required this.comment,
    required this.datePub,
    required this.likes,
    required this.profilePic,
    required this.uid,
    required this.id,
});

  Map<String, dynamic> toJson()=>{
    "username": userName,
    "comment": comment,
    "datePub":datePub,
    "likes":likes,
    "profilePic":profilePic,
    "uid":uid,
    "id":id,
  };

  static Comment fromSnap(DocumentSnapshot snapshot){
    var snap = snapshot.data() as Map<String, dynamic>;
    return Comment(userName: snap["username"], comment: snap['comment'], datePub: snap['datePub'], likes: snap['likes'], profilePic: snap['profilePic'], uid: snap['uid'], id: snap['id']);
  }

}