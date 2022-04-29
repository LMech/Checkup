import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/auth/sign_in_ui.dart';
import 'package:checkup/views/components/form_input_field_with_icon.dart';
import 'package:checkup/views/components/label_button.dart';
import 'package:checkup/views/components/logo_graphic_header.dart';
import 'package:checkup/views/components/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordUI extends StatelessWidget {
  ResetPasswordUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: const Text('Reset'));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'Sign in',
        onPressed: () => Get.offAll(() => SignInUI()),
      );
    }
    return const SizedBox(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
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
                    controller: authController.emailController,
                    iconPrefix: CupertinoIcons.mail,
                    labelText: 'Email',
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => '',
                    onSaved: (value) =>
                        authController.emailController.text = value as String,
                    onEditdingComplete: () {},
                  ),
                  const SizedBox(),
                  PrimaryButton(
                      labelText: 'Reset',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.sendPasswordResetEmail(context);
                        }
                      }),
                  const SizedBox(),
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
