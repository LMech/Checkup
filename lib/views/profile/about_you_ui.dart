import 'package:checkup/controllers/about_you_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbouYouUI extends StatefulWidget {
  const AbouYouUI({Key? key}) : super(key: key);

  @override
  State<AbouYouUI> createState() => _AbouYouUIState();
}

class _AbouYouUIState extends State<AbouYouUI> {
  String dropdownValue = 'Male';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutYouController>(
      init: AboutYouController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("About You"),
          ),
          body: SafeArea(child: _aboutYou(controller)),
        );
      },
    );
  }

  // Future<DateTime?> _presentDatePicker() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(2000),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   return picked;
  // }

  Widget _aboutYou(AboutYouController controller) {
    return Column(
      children: [TextField(controller: controller.nameTextController)],
    );
  }
}
