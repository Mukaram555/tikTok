import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticktok/view/auth/login_screen.dart';
import 'package:ticktok/view/screens/home_page.dart';

import '../model/user.dart';

class AuthController extends GetxController {


  static AuthController instance = Get.find();
  File? proImg;
  pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    final img = File(image!.path);
    proImg = img;
  }

  // User state Persistence

  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // Observable keyword - Continuously checking variable is changing or not
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);

  }
  _setInitialView(User? user){
    if(user == null){
      Get.offAll(()=> LoginPage());
    }else{
      Get.offAll(()=>const HomePage());
    }
  }

  //User Register

  void signUp(
    String userName,
    String email,
    String password,
    File image,
  ) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
      image != null) {
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProfileImage(image);
        MyUser user = MyUser(name: userName, profilePic: downloadUrl, email: email, uid: credential.user!.uid);
        await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
        Get.snackbar("Account Created", "Your Account is created Successfully");
        Get.to(HomePage());
      }else{
        Get.snackbar("Error Creating Account", "Please Enter All the Required Fields");
      }
    } catch (e) {
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _uploadProfileImage(File image) async {

    // var refer = await FirebaseStorage.instance.ref

    var reference = FirebaseStorage.instance
        .ref()
        .child("profilePic")
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void login(String email, String password)async {
    try{
      if(email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Get.to(const HomePage());
        Get.snackbar("Login", "Login Successfully");
      }
    }catch(e){
      Get.snackbar("Error Logging In", e.toString());
    }
  }
  
  signOut(){
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginPage());
  }
}
