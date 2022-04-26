import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUserUI extends StatefulWidget {
  AboutUserUI({Key? key}) : super(key: key);

  @override
  State<AboutUserUI> createState() => _AboutUserUIState();
}

class _AboutUserUIState extends State<AboutUserUI> {
  final ProfileController profileController = ProfileController.to;
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate = pickedDate;
      });
    });
  }

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About You"),
      ),
      body: SafeArea(child: _aboutYou()),
    );
  }

  _aboutYou() {
    return Container(
        child: Form(
            // key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
          FormInputFieldWithIcon(
            controller: profileController.phoneNumberController,
            iconPrefix: CupertinoIcons.phone,
            keyboardType: TextInputType.datetime,
            labelText: "Phone Number",
            validator: Validator().name,
            onEditdingComplete: () async {
              await profileController.updateDB(
                  'phoneNumber', profileController.phoneNumberController.text);
            },
          ),
          const FormVerticalSpace(),
          FormInputFieldWithIcon(
            controller: profileController.dataOfBirthController,
            iconPrefix: CupertinoIcons.calendar,
            keyboardType: TextInputType.datetime,
            labelText: "Date of Birth",
            validator: Validator().name,
            onTap: () {
              _presentDatePicker();
              profileController.dataOfBirthController.text =
                  _selectedDate.toString();
            },
            onEditdingComplete: () async {
              await profileController.updateDB(
                  'dateOfBirth', profileController.dataOfBirthController.text);
            },
          ),
          const FormVerticalSpace(),
          FormInputFieldWithIcon(
              controller: profileController.heightController,
              iconPrefix: Icons.height_sharp,
              keyboardType: TextInputType.number,
              labelText: "Height",
              validator: Validator().number,
              onEditdingComplete: () async {
                await profileController.updateDB('dateOfBirth',
                    profileController.dataOfBirthController.text);
              }),
          const FormVerticalSpace(),
          FormInputFieldWithIcon(
              controller: profileController.weightController,
              iconPrefix: Icons.monitor_weight,
              keyboardType: TextInputType.datetime,
              labelText: "Weight",
              validator: Validator().number,
              onEditdingComplete: () async {
                await profileController.updateDB('dateOfBirth',
                    profileController.dataOfBirthController.text);
              })
        ])));
  }
}