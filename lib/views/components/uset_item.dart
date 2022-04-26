import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/friends_controll.dart';
import 'action_button.dart';
import 'avatar.dart';

class UserItem extends StatefulWidget {
  final String userId;
  final bool isFriend;
  final bool isRequest;
  final Function? onAddFriendPressed;
  final Function? onDeleteRequestPressed;
  final Function? onAcceptRequestPressed;

  const UserItem({
    Key? key,
    required this.userId,
    this.isFriend = true,
    this.isRequest = false,
    this.onAddFriendPressed,
    this.onDeleteRequestPressed,
    this.onAcceptRequestPressed,
  }) : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  final FriendsController controller = Get.find();

  bool _isRequestSent = false;
  bool _isRequestAccepted = false;
  bool _isRequestDeleted = false;

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.userDataMap!['uid']);
    return Card(
      // color: Colors.grey[100],
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Theme.of(context).splashColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: controller.photoUrl == ''
                          ? CircleAvatar(
                              child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                      placeholder: '',
                                      image: controller.photoUrl,
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 120)),
                              radius: 25)
                          // TODO: remember to change
                          : Avatar(
                              controller.userDataMap!['photourl'],
                              width: 25,
                              radius: 25,
                              height: 25,
                            )),
                  title: Text(
                    controller.userDataMap!['name'],
                  ),
                  subtitle: Text(
                    controller.userDataMap!['email'],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: !widget.isFriend
                      ? _isRequestAccepted ||
                              _isRequestDeleted ||
                              _isRequestSent
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                _isRequestAccepted
                                    ? 'You are now friends. click to start chatting!'
                                    : _isRequestSent
                                        ? 'Request Sent'
                                        : 'Request Deleted',
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomActionButton(
                                  title: widget.isRequest
                                      ? 'Accept Request'
                                      : 'Add Friend',
                                  onPressed: widget.isRequest
                                      ? _onAcceptRequestPressed
                                      : _onAddFriendPressed,
                                ),
                                const SizedBox(width: 10),
                                widget.isRequest
                                    ? CustomActionButton(
                                        title: 'Delete',
                                        onPressed: _onDeleteRequestPressed,
                                      )
                                    : Container()
                              ],
                            )
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Function _onAcceptRequestPressed() {
    setState(() {
      _isRequestAccepted = true;
    });
    return widget.onAcceptRequestPressed!();
  }

  Function _onAddFriendPressed() {
    setState(() {
      _isRequestSent = true;
    });
    return widget.onAddFriendPressed!();
  }

  void _onDeleteRequestPressed() {
    setState(() {
      _isRequestDeleted = true;
    });
    widget.onDeleteRequestPressed!();
  }
}
