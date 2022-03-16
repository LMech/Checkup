import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'customactionbutton.dart';

class UserItem extends StatefulWidget {
  final DocumentSnapshot userDocument;
  final bool isFriend;
  final bool isRequest;
  final Function? onAddFriendPressed;
  final Function? onDeleteRequestPressed;
  final Function? onAcceptRequestPressed;

  const UserItem({
    required this.userDocument,
    this.isFriend = true,
    this.isRequest = false,
    this.onAddFriendPressed,
    this.onDeleteRequestPressed,
    this.onAcceptRequestPressed,
  });

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool _isRequestSent = false;
  bool _isRequestAccepted = false;
  bool _isRequestDeleted = false;

  @override
  Widget build(BuildContext context) {
    return Container();
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
