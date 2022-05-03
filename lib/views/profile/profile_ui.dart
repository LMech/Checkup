import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/views/components/avatar.dart';
import 'package:checkup/views/components/list_tile_with_icon.dart';
import 'package:checkup/views/profile/about_user_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
class ProfileUI extends StatelessWidget {
  ProfileUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;

  Widget _profileData() {
    final String userName = authController.firestoreUser.value!.name;
    final String email = authController.firestoreUser.value!.email;

    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          child: authController.firestoreUser.value!.photoUrl == ''
              ? Avatar(
                  authController.firestoreUser.value!.photoUrl,
                  radius: 50.0,
                  height: 120,
                  width: 200,
                )
              : CircleAvatar(
                  child: ClipOval(
                      child: FadeInImage.assetNetwork(
                          placeholder: '',
                          image: authController.firestoreUser.value!.photoUrl,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 120)),
                  radius: 50),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        Text(
          userName,
          style: const TextStyle(fontSize: 28.0),
        ),
        const SizedBox(height: 5),
        Text(email),
      ],
    );
  }

  Widget _listView() {
    return Expanded(
      child: ListView(children: [
        ListTileWithIcon(
          title: "About Me",
          icon: Icons.arrow_forward_ios_outlined,
          size: 20.0,
          onTap: () => Get.to(() => const AboutUserUI()),
        ),
        ListTileWithIcon(
          title: "Medical ID",
          icon: Icons.arrow_forward_ios_outlined,
          size: 20.0,
          onTap: () => Get.to(() => const AboutUserUI()),
        ),
        ListTileWithIcon(
            title: "Sign Out",
            color: const Color.fromARGB(71, 232, 88, 88),
            icon: Icons.logout_sharp,
            size: 20.0,
            onTap: () => AuthController.to.signOut()),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
                body: SafeArea(
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                _profileData(),
                const SizedBox(height: 10),
                _listView(),
              ]),
            ))));
  }
}

    

// class ProfileListItems extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         children: const <Widget>[
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Privacy',
//           ),
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Purchase History',
//           ),
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Help & Support',
//           ),
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Settings',
//           ),
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Invite a Friend',
//           ),
//           ProfileListItem(
//             icon: Icons.abc,
//             text: 'Logout',
//             hasNavigation: false,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AppBarButton extends StatelessWidget {
//   final IconData icon;

//   const AppBarButton({required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 55,
//       height: 55,
//       decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
//         BoxShadow(
//           offset: Offset(1, 1),
//           blurRadius: 10,
//         ),
//         BoxShadow(
//           offset: Offset(-1, -1),
//           blurRadius: 10,
//         ),
//       ]),
//       child: Icon(
//         icon,
//       ),
//     );
//   }
// }