import 'package:checkup/controllers/medical_item_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/core/components/form_input_field_with_icon.dart';
import 'package:checkup/views/core/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class AddItemUI extends StatelessWidget {
  AddItemUI({Key? key}) : super(key: key);
  final MedicalItemController medicalItemController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${medicalItemController.name}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FormInputFieldWithIcon(
                controller: medicalItemController.elementController,
                iconPrefix: UniconsLine.head_side_cough,
                labelText: medicalItemController.name.capitalize!,
                validator: Validator().notEmpty,
                edgeInsets: const EdgeInsets.all(56.0),
              ),
              PrimaryButton(
                labelText: 'Add',
                onPressed: () {
                  medicalItemController
                      .addItem(medicalItemController.elementController.text);
                  medicalItemController.elementController.clear();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
