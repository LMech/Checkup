import 'package:checkup/controllers/about_you_controller.dart';
import 'package:checkup/helpers/datetime_picker.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/core/components/dropdown_with_icons.dart';
import 'package:checkup/views/core/components/form_input_field_with_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _aboutYou(controller),
            ),
          ),
        );
      },
    );
  }

  Widget _aboutYou(AboutYouController controller) {
    return Column(
      children: [
        FormInputFieldWithIcon(
          controller: controller.nameTextController,
          iconPrefix: UniconsLine.user,
          labelText: 'Name',
          validator: Validator().notEmpty,
          onChanged: (newValue) {
            controller.updateValue('name', newValue);
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        FormInputFieldWithIcon(
          controller: controller.phoneNubmerTextController,
          iconPrefix: UniconsLine.phone_alt,
          labelText: 'Phone Number',
          validator: Validator().number,
          keyboardType: TextInputType.number,
          onChanged: (newValue) {
            controller.updateValue('phoneNumber', newValue);
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        FormInputFieldWithIcon(
          controller: controller.addressTextController,
          iconPrefix: UniconsLine.location_arrow,
          labelText: 'Addresss',
          validator: Validator().notEmpty,
          onChanged: (newValue) {
            controller.updateValue('address', newValue);
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Expanded(
              child: FormInputFieldWithIcon(
                controller: controller.weightTextController,
                iconPrefix: UniconsLine.weight,
                labelText: 'Weight',
                validator: Validator().number,
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  controller.updateValue('weight', int.parse(newValue));
                },
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: FormInputFieldWithIcon(
                controller: controller.heightTextController,
                iconPrefix: UniconsLine.ruler,
                labelText: 'Height',
                validator: Validator().number,
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  controller.updateValue('height', int.parse(newValue));
                },
              ),
            ),
          ],
        ),
        Obx(
          () => FormInputFieldWithIcon(
            controller: controller.dobTextController.value,
            iconPrefix: UniconsLine.user,
            labelText: 'Date of Birth',
            validator: Validator().notEmpty,
            keyboardType: TextInputType.none,
            onTap: () async {
              final DateTime? picked =
                  await DateTimePicker.instance.presentDatePicker(Get.context!);
              if (picked != null) {
                controller.updateValue(
                  'dateOfBirth',
                  Timestamp.fromDate(picked),
                );
                controller.updateDob(picked);
              }
            },
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Obx(
          () => DropdownPickerWithIcon(
            menuOptions: controller.genderItems,
            selectedOption: controller.genderSelected.value,
            onChanged: (newValue) {
              controller.updateValue('gender', newValue);
            },
            icon: UniconsLine.mars,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Obx(
          () => DropdownPickerWithIcon(
            menuOptions: controller.bloodTypeItems,
            selectedOption: controller.bloodTypeSelected.value,
            onChanged: (newValue) {
              controller.updateValue('bloodType', newValue);
              controller.updateBloodType(newValue ?? '');
            },
            icon: Icons.bloodtype_outlined,
          ),
        )
      ],
    );
  }
}
