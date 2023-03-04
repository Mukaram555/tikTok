import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ticktok/view/screens/home_page.dart';
import 'package:video_compress/video_compress.dart';

import '../model/video_model.dart';

//Functions format

// uploadVideo
// Video To Storage
// Video Compress
//Video ThumbNail Generator
//Video Thumb To Storage

class VideoUploadController extends GetxController {
  static VideoUploadController instance = Get.find();
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      // video unique id we will use =>uuid
      String uuid =
          Timer(const Duration(seconds: Duration.millisecondsPerSecond), () {})
              as String;
      String videoURL = await uploadVideoToStorage(uuid, videoPath);
      String thumbNail = await uploadVideoThumbToStorage(uuid, videoPath);

      Video video = Video(
        uid: uid,
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        videoUrl: videoURL,
        thumbNail: thumbNail,
        songName: songName,
        shareCount: 0,
        commentsCount: 0,
        likes: [],
        proFilePic: (userDoc.data()! as Map<String, dynamic>)['proFilePic'],
        caption: caption,
        id: uuid,
      );
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(uuid)
          .set(video.toJson());
      Get.snackbar("Video Uploaded", "Your Video is Uploaded Successfully");
      Get.to(HomePage());
    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }

  Future<String> uploadVideoThumbToStorage(String Id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("ThumbNail").child(Id);
    UploadTask uploadTask = reference.putFile(await getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File> getThumb(String videoPath) async {
    final thumbNail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbNail;
  }

  Future<String> uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("Videos").child(videoID);
    UploadTask uploadTask = reference.putFile(_compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }
}
