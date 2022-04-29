import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/auth/sign_in_ui.dart';
import 'package:checkup/views/components/form_input_field_with_icon.dart';
import 'package:checkup/views/components/label_button.dart';
import 'package:checkup/views/components/logo_graphic_header.dart';
import 'package:checkup/views/components/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpUI extends StatelessWidget {
  SignUpUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    iconPrefix: CupertinoIcons.person,
                    labelText: 'Name',
                    validator: Validator().name,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                    onEditdingComplete: () {},
                  ),
                  const SizedBox(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: CupertinoIcons.mail,
                    labelText: 'Email',
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                    onEditdingComplete: () {},
                  ),
                  const SizedBox(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: CupertinoIcons.lock,
                    labelText: 'Password',
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                    onEditdingComplete: () {},
                  ),
                  const SizedBox(),
                  PrimaryButton(
                      labelText: 'Sign Up'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  const SizedBox(),
                  LabelButton(
                    labelText: 'Already have an accound, sign in',
                    onPressed: () => Get.to(() => SignInUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
