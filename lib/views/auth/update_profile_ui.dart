import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/helpers/helpers.dart';
import 'package:checkup/models/user_model.dart';
import 'package:checkup/views/auth/auth.dart';
import 'package:checkup/views/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('user.name: ' + user?.value?.name);
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;
    return Scaffold(
      appBar: AppBar(title: Text('auth.updateProfileTitle'.tr)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const LogoGraphicHeader(
                    radius: 20,
                    height: 120,
                    width: 200,
                  ),
                  const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: 'Name',
                    validator: Validator().name,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                    onEditdingComplete: () {},
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'Email'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                    onEditdingComplete: () {},
                  ),
                  const FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.updateUser'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: authController.firestoreUser.value!.uid,
                              name: authController.nameController.text,
                              email: authController.emailController.text,
                              photoUrl:
                                  authController.firestoreUser.value!.photoUrl);
                          _updateUserConfirm(context, _updatedUser,
                              authController.firestoreUser.value!.email);
                        }
                      }),
                  const FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(() => ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = TextEditingController();
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          'auth.enterPassword'.tr,
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: 'auth.passwordFormField'.tr,
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              return 'Password';
            } else {
              return null;
            }
          },
          obscureText: true,
          onChanged: (value) => '',
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
          onEditdingComplete: () {},
        ),
        actions: <Widget>[
          TextButton(
            child: Text('auth.cancel'.tr.toUpperCase()),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('auth.submit'.tr.toUpperCase()),
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}
