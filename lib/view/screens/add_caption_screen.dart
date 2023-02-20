import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ticktok/const/colors.dart';
import 'package:ticktok/controller/upload_video.dart';
import 'package:ticktok/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  AddCaptionScreen(
      {Key? key, required this.videoFile, required this.videoPath,})
      : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  VideoUploadController videoUploadController =  Get.put(VideoUploadController(),);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });

    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInput(controller: songNameController,
                    myIcon: Icons.music_note,
                    myLabel: 'Song Name',
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(controller: captionController,
                    myIcon: Icons.closed_caption,
                    myLabel: 'Song Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () {
                    videoUploadController.uploadVideo(songNameController.text, captionController.text, widget.videoPath);
                  },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor),
                    child: const Text("Upload"),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
