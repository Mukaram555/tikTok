import 'package:flutter/material.dart';
import 'package:ticktok/controller/searchuser_controller.dart';
import 'package:ticktok/view/screens/profile_screen.dart';
import 'package:ticktok/widgets/text_input.dart';
import 'package:get/get.dart';

import '../../model/user.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchQuery = TextEditingController();
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15,bottom: 11,right: 15,top: 11
                ),
                hintText: "Search Here",
              ),
              controller: searchQuery,
              onFieldSubmitted: (value) {
                searchController.searchUser(value);
              },
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text("Search User!"),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    MyUser user = searchController.searchedUsers[index];
                    return ListTile(
                      onTap: () {
                        Get.to(ProfileScreen(uid: user.uid));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePic,
                        ),
                      ),
                      title: Text(user.name),
                    );
                  }));
    });
  }
}
