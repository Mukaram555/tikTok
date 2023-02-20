import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentsCount;
  int shareCount;
  String caption;
  String videoUrl;
  String thumbNail;
  String proFilePic;
  String songName;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.thumbNail,
    required this.caption,
    required this.commentsCount,
    required this.proFilePic,
    required this.shareCount,
    required this.videoUrl,
    required this.songName,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePic": proFilePic,
        "id": id,
        "likes": likes,
        "commentCount": commentsCount,
        "ShareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "ThumbNail": thumbNail,
      };

  static Video fromSnap(DocumentSnapshot snapshot) {
    var sst = snapshot.data() as Map<String, dynamic>;
    return Video(
      username: sst["username"],
      uid: sst["uid"],
      id: sst["id"],
      likes: sst["likes"],
      thumbNail: sst["thumbNail"],
      caption: sst["caption"],
      commentsCount: sst["commentCount"],
      proFilePic: sst["proFilePic"],
      shareCount: sst["shareCount"],
      videoUrl: sst["videoUrl"],
      songName: sst["songName"],
    );
  }
}
