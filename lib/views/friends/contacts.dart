import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/friends_controll.dart';

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);

  final AddFriendController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.group),
          onPressed: () {
            Get.bottomSheet(Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20) ,topRight: Radius.circular(20),
              ),),

              child: controller.isLoading
                  ? Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          child: TextField(
                            controller: controller.search,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  print("ssssssssssssssssss");
                                  controller.onSearch;
                                  print("nnnnnnnnnnnnnnnn");

                                },
                                child: Icon(Icons.search),
                              ),
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(controller.userMap!['email']),
                                trailing: InkWell(
                                  onTap: () {
                                    controller.sendfriendrequest(
                                        controller.userMap!['uid']);
                                  },
                                  child: Icon(Icons.add, color: Colors.black),
                                ),
                              )
                            : Container(),
                      ],
                    ),
            ));
          }),
    );
  }
}
