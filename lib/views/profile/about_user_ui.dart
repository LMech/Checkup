import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/components/form_input_field_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AboutUserUI extends StatefulWidget {
  const AboutUserUI({Key? key}) : super(key: key);

  @override
  State<AboutUserUI> createState() => _AboutUserUIState();
}

class _AboutUserUIState extends State<AboutUserUI> {
  String dropdownValue = 'Male';
  final ProfileController profileController = ProfileController.to;

  Future<DateTime?> _presentDatePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    return picked;
  }

  _aboutYou() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
            child: ListView(children: <Widget>[
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 8.0),
          FormInputFieldWithIcon(
            controller: profileController.dataOfBirthController,
            iconPrefix: CupertinoIcons.calendar,
            keyboardType: TextInputType.none,
            labelText: "Date of Birth",
            validator: Validator().name,
            onTap: () async {
              DateTime? picked = await _presentDatePicker();
              if (picked != null) {
                String formated = DateFormat.yMd().format(picked);
                profileController.dataOfBirthController.text = formated;
                await profileController.updateDB('dateOfBirth',
                    profileController.dataOfBirthController.text);
              }
            },
            onEditdingComplete: () async {},
          ),
          const SizedBox(height: 8.0),
          FormInputFieldWithIcon(
              controller: profileController.heightController,
              iconPrefix: Icons.home_outlined,
              keyboardType: TextInputType.streetAddress,
              labelText: "Address",
              validator: Validator().number,
              onEditdingComplete: () async {
                await profileController.updateDB('dateOfBirth',
                    profileController.dataOfBirthController.text);
              }),
          const SizedBox(height: 8.0),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: ['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 8.0),
          FormInputFieldWithIcon(
              controller: profileController.weightController,
              iconPrefix: Icons.monitor_weight,
              keyboardType: TextInputType.datetime,
              labelText: "Weight",
              validator: Validator().number,
              onEditdingComplete: () async {
                await profileController.updateDB('dateOfBirth',
                    profileController.dataOfBirthController.text);
              }),
          const SizedBox(height: 8.0),
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About You"),
      ),
      body: SafeArea(child: _aboutYou()),
    );
  }
}
