import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/helpers/helpers.dart';
import 'package:checkup/views/auth/auth.dart';
import 'package:checkup/views/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpUI({Key? key}) : super(key: key);

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
                  LogoGraphicHeader(),
                  const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: CupertinoIcons.person,
                    labelText: 'auth.nameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: CupertinoIcons.mail,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: CupertinoIcons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.signUpButton'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.signInLabelButton'.tr,
                    onPressed: () => Get.to(SignInUI()),
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
