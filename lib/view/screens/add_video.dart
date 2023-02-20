import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticktok/const/colors.dart';
import 'package:ticktok/view/screens/add_caption_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  videoPick(ImageSource src , BuildContext context) async{
    final ImagePicker picker = ImagePicker();
    final video = await picker.pickVideo(source: src);
    if(video != null){
      Get.snackbar("Video Selected",video.path);
      Get.to(AddCaptionScreen(videoFile: File(video.path), videoPath: video.path),);
    }
    else{
      Get.snackbar("No Video Selected", "Please choose a different Video");
    }
  }
  showDialogOpt(context){
    return showDialog(context: context, builder: (context)=>SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: (){
            videoPick(ImageSource.gallery,context);
          },
          child: const Text("Gallery"),
        ),

        SimpleDialogOption(
          onPressed: (){
            videoPick(ImageSource.camera,context);
          },
          child: const Text("Camera"),
        ),

        SimpleDialogOption(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showDialogOpt(context);
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
