import 'dart:core';

import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/helpers/validator.dart';
import 'package:checkup/views/core/components/form_input_field_with_icon.dart';
import 'package:checkup/views/core/components/label_button.dart';
import 'package:checkup/views/core/components/logo_graphic_header.dart';
import 'package:checkup/views/core/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInUI extends StatelessWidget {
  SignInUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                      radius: 73.0,
                    ),
                    const SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.alternate_email_outlined,
                      labelText: 'Email',
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => '',
                      onSaved: (value) =>
                          authController.emailController.text = value!,
                      onEditdingComplete: () {},
                    ),
                    const SizedBox(height: 8.0),
                    FormInputFieldWithIcon(
                      controller: authController.passwordController,
                      iconPrefix: Icons.password_outlined,
                      labelText: 'Password',
                      validator: Validator().password,
                      obscureText: true,
                      onChanged: (value) => '',
                      onSaved: (value) =>
                          authController.passwordController.text = value!,
                      maxLines: 1,
                      onEditdingComplete: () {},
                    ),
                    const SizedBox(height: 8.0),
                    PrimaryButton(
                      labelText: 'Sign in',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithEmailAndPassword(context);
                        }
                      },
                    ),
                    const SizedBox(height: 8.0),
                    LabelButton(
                      labelText: 'Reset password',
                      onPressed: () => Get.toNamed('/reset-password'),
                    ),
                    LabelButton(
                      labelText: 'Sign up',
                      onPressed: () => Get.toNamed('/signup'),
                    ), /*  */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}
