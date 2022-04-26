import 'package:checkup/controllers/add_friends_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactUI extends GetWidget<AddFriendController> {
  const AddContactUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFriendController>(
        init: AddFriendController(),
        builder: (controller) {
          return Scaffold(
              body: Container(
            margin: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: TextField(
                          controller: controller.search,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.onsearch();
                              },
                              child: const Icon(Icons.search),
                            ),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      controller.userMap != null
                          ? ListTile(
                              leading: CircleAvatar(
                                child: Image.network(
                                    controller.userMap!['photoUrl']),
                              ),
                              title: Text(
                                controller.userMap!['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(controller.userMap!['email']),
                              trailing: InkWell(
                                onTap: () {
                                  //    controller.sendfriendrequest(
                                  //  controller.userMap!['uid']);
                                },
                                child:
                                    const Icon(Icons.add, color: Colors.black),
                              ),
                            )
                          : Container(),
                    ],
                  ),
          ));
        });
  }
}
