import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFA500), // Orange
                  Color(0xFF2196F3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ), // Adjust for keyboard
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Decorative Icon or Illustration
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 100,
                        color: theme.iconTheme.color,
                      ),
                    ),
                    // Login card with glassmorphism effect
                    Container(
                      height: mediaQuery.height * 0.55,
                      width: mediaQuery.width * 0.85,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: theme.cardColor
                            .withOpacity(0.15), // Use theme's card color
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Login text
                          Text(
                            'Welcome Back!',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: theme.textTheme.headlineLarge?.color,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Username TextField
                          TextField(
                            controller: controller.usernameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                  color: theme.iconTheme.color),
                              labelText: 'Username',
                              labelStyle: theme.inputDecorationTheme.labelStyle,
                              filled: true,
                              fillColor: theme.inputDecorationTheme.fillColor
                                  ?.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Password TextField
                          TextField(
                            controller: controller.passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,
                                  color: theme.iconTheme.color),
                              labelText: 'Password',
                              labelStyle: theme.inputDecorationTheme.labelStyle,
                              filled: true,
                              fillColor: theme.inputDecorationTheme.fillColor
                                  ?.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Login button with animation and elevation
                          Obx(
                            () => controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: theme.elevatedButtonTheme
                                              .style?.backgroundColor
                                              ?.resolve(
                                                  {MaterialState.pressed}) ??
                                          Colors.orange,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 80),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 10,
                                    ),
                                    child: Text(
                                      'Login',
                                      style: theme.textTheme.headlineSmall,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
