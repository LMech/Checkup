import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AboutYouController extends GetxController {
  List<DropdownMenuItem<String>> bloodTypeItems = [
    const DropdownMenuItem(
      value: '',
      child: Text('Blood Type'),
    ),
    const DropdownMenuItem(value: 'A+', child: Text('A+')),
    const DropdownMenuItem(value: 'A-', child: Text('A-')),
    const DropdownMenuItem(value: 'B+', child: Text('B+')),
    const DropdownMenuItem(value: 'B-', child: Text('B-')),
    const DropdownMenuItem(value: 'AB+', child: Text('AB+')),
    const DropdownMenuItem(value: 'AB-', child: Text('AB-')),
    const DropdownMenuItem(value: 'O+', child: Text('O+')),
    const DropdownMenuItem(value: 'O-', child: Text('O-')),
  ];

  List<DropdownMenuItem<String>> genderItems = [
    const DropdownMenuItem(
      value: '',
      child: Text('Gender'),
    ),
    const DropdownMenuItem(value: 'male', child: Text('Male')),
    const DropdownMenuItem(value: 'female', child: Text('Female')),
  ];

  RxString bloodTypeSelected =
      (AuthController.to.firestoreUser.value!.bloodType).obs;
  Rx<TextEditingController> dobTextController = TextEditingController(
    text: DateFormat('yMMMMd')
        .format(AuthController.to.firestoreUser.value!.dateOfBirth),
  ).obs;
  final TextEditingController addressTextController = TextEditingController(
    text: AuthController.to.firestoreUser.value!.address,
  );
  final RxString genderSelected =
      (AuthController.to.firestoreUser.value!.gender).obs;
  final TextEditingController heightTextController = TextEditingController(
    text: AuthController.to.firestoreUser.value!.height == 0
        ? ''
        : AuthController.to.firestoreUser.value!.height.toString(),
  );

  final TextEditingController nameTextController =
      TextEditingController(text: AuthController.to.firestoreUser.value!.name);

  final TextEditingController phoneNubmerTextController = TextEditingController(
    text: AuthController.to.firestoreUser.value!.phoneNumber,
  );

  final TextEditingController weightTextController = TextEditingController(
    text: AuthController.to.firestoreUser.value!.weight == 0
        ? ''
        : AuthController.to.firestoreUser.value!.weight.toString(),
  );

  Future<void> updateValue(String field, dynamic value) async {
    FirestoreOperations.instance.updateDocumentWithkey(
      AuthController.to.firestoreUser.value!.email,
      {field: value},
    );
  }

  void updateGender(String newValue) => genderSelected(newValue);
  void updateBloodType(String newValue) => bloodTypeSelected(newValue);
  void updateDob(DateTime picked) {
    dobTextController(
      TextEditingController(
        text: DateFormat('yMMMMd').format(picked),
      ),
    );
  }
}
