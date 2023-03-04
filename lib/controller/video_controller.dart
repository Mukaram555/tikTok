import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ticktok/model/video_model.dart';
import 'auth_controller.dart';

class VideoController extends GetxController{
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance.collection("Videos").snapshots().map((QuerySnapshot query){
      List<Video> retVideo = [];
      for(var element in query.docs){
        retVideo.add(Video.fromSnap(element));
      }
      return retVideo;
    }));
  }

  shareVideo(String vidId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("videos").doc(vidId).get();
    int newShareCount = (doc.data() as dynamic)['shareCount']+1;
    await FirebaseFirestore.instance.collection("videos").doc(vidId).update({
'shareCount' : newShareCount,
    });
  }

  likesVideo(String id)async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("videos").doc(id).get();
    var uid = AuthController.instance.user.uid;
    if((doc.data() as dynamic)["likes"].contains(uid)){
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        "likes" : FieldValue.arrayRemove([uid]),
      });
    }else{
      await FirebaseFirestore.instance.collection("videos").doc(id).update(
          {
            "likes" : FieldValue.arrayUnion([uid]),
          });
    }
  }

}