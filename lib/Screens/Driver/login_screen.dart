import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/login_controller.dart';
import 'package:om/Utils/utils.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor, // Use theme color
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor, // Use theme background color
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Login',
                style: Get.theme.textTheme.headlineMedium?.copyWith(
                  color: Get.theme.primaryColor, // Use theme colors
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                  ),
                  hintText: 'Enter your username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                  ),
                  hintText: 'Enter your password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : submitButton(text: 'Login', onPressed: controller.login)),
            ],
          ),
        ),
      ),
    );
  }
}
