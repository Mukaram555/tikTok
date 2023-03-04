import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/comment_model.dart';

class CommentController extends GetxController{
  final user = FirebaseAuth.instance;

  final Rx<List<Comment>> _comment = Rx<List<Comment>>([]);
  List<Comment> get comments => _comment.value;
  String postID = "";
  updatePostID(String id){
    postID = id;
    fetchComment();
  }
  fetchComment()async{
    _comment.bindStream(FirebaseFirestore.instance.collection("videos").doc(postID).collection("comments").snapshots().map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for(var elements in query.docs){
        retVal.add(Comment.fromSnap(elements));
      }
      return retVal;
    }));
  }
  postComment(String commentText) async{
    try{
      if(commentText.isNotEmpty){
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(user.currentUser!.uid.toString()).get();
        var allDoc = await FirebaseFirestore.instance.collection("videos").doc(postID).collection("comments").get();
        int len = allDoc.docs.length;

        Comment comment = Comment(
          userName: (userDoc.data() as dynamic)['name'],
          comment: commentText.trim(),
          datePub: DateTime.now(),
          likes : [],
          profilePic: (userDoc.data() as dynamic)['profilePic'],
          uid: user.currentUser!.uid,
          id: 'Comment $len',
        );

        await FirebaseFirestore.instance.collection("videos").doc(postID).collection("comment").doc("Comment $len").set(comment.toJson());

        DocumentSnapshot doc = await FirebaseFirestore.instance.collection("videos").doc(postID).get();
        await FirebaseFirestore.instance.collection("videos").doc(postID).update(
            {
              'commentsCount' : (doc.data() as dynamic)['commentsCount']+1,

            });
      }
      else{
        Get.snackbar("Please Enter Something", "Please Write Something in Comment");
      }
    }catch(e){
      Get.snackbar("Error in Uploading Comment", e.toString());
    }
  }
  likeComment(String id) async{
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("videos").doc(postID).collection("comments").doc(id).get();
    if((doc.data()! as dynamic)['likes'].contains(uid)){
      await FirebaseFirestore.instance.collection('videos').doc(postID).collection('comments').doc(id).update({
        'likes' : FieldValue.arrayRemove([uid]),
      });
    }else{
      await FirebaseFirestore.instance.collection('videos').doc(postID).collection('comments').doc(id).update({
        'likes' : FieldValue.arrayUnion([uid]),
      });
    }
  }

}

