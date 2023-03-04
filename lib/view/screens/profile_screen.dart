import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktok/controller/auth_controller.dart';
import 'package:ticktok/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  String uid;

  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return controller.user.isEmpty? const Center(
            child: CircularProgressIndicator(),
          ): Scaffold(
            appBar: AppBar(
              title: Text('@${controller.user['name']}'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: (){
                    Get.snackbar("TikTok Clone", "The Current Version is 1.0");
                  },
                  icon: Icon(Icons.info_outline_rounded),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: controller.user['profilePic'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.user['followers'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.user['following'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.user['likes'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "likes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: (){
                        if (widget.uid ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          authController.signOut();
                        } else {
                          controller.followUser(widget.uid);
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white60,
                            width: 0.6
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(widget.uid ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? "Sign Out"
                              : controller.user['isFollowing']
                                  ? 'following'
                                  : "unfollow"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: controller.user['thumbnails'].length,
                        itemBuilder: (context, index) {
                          String thumbnail =
                              controller.user['thumbnails'][index];
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: thumbnail,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
