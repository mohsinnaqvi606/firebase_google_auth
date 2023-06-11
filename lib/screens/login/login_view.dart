import 'package:firebase_google_auth/screens/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginViewModel loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginButton(),
            Obx(
              () => Text(
                loginViewModel.response.value,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Login With Google'),
      centerTitle: true,
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        loginViewModel.loginButton2();
      },
      child: const Text('Login With Google'),
    );
  }
}
