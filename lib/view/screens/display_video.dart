import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktok/controller/video_controller.dart';
import 'package:ticktok/view/screens/comment_screen.dart';
import '../../widgets/album_rotator.dart';
import '../../widgets/profile_button.dart';
import '../../widgets/tiktok_video_player.dart';

class DisplayVideoScreen extends StatelessWidget {
  DisplayVideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                TikTokVideoPlayer(
                  videoUrl: data.videoUrl,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.username,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(data.caption),
                      Text(
                        data.songName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 400,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3,
                              right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileButton(
                                profilePhotoUrl: data.proFilePic,
                              ),
                              InkWell(
                                onTap: () {
                                  videoController.likesVideo(data.id);
                                },
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      size: 45,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      data.likes.length.toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.replay,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(CommentScreen(id: data.id));
                                },
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.comment,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.commentsCount.toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  AlbumRotator(
                                    profilePicUrl: data.proFilePic,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
