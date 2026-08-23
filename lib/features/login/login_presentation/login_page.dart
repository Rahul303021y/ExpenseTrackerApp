import 'package:expensetrackerapp/core/helpers/device_info_helpers.dart';
import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/common_ui/app_button.dart';
import 'package:expensetrackerapp/shared/common_ui/app_logo_text.dart';
import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:expensetrackerapp/shared/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/common/main_screen.dart';
import '../login_bloc/login_bloc.dart';
import '../login_bloc/login_event.dart';
import '../login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final deviceInfo =
    await DeviceInfoHelper.getDeviceInfo();

    if (!mounted) return;

    context.read<LoginBloc>().add(
      LoginButtonPressedEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        // deviceId: deviceInfo['deviceId'] ?? '',
        // deviceName: deviceInfo['deviceName'] ?? '',
        deviceId: "Demo",
        deviceName: "Demo",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MainScreen(),
              ),
            );
          }

          if (state is LoginFailure) {
            CustomSnackbar.error(
              context,
              "Login Failed",
            );
          }
        },
        builder: (context, state) {
          return AppBackground(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const AppLogoText(),

                      const SizedBox(height: 70),

                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Email Address",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: emailController,
                        hintText:
                        "Enter your Email Address",
                        textColor: Colors.white,
                        borderColor:
                        Colors.white.withOpacity(0.4),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: passwordController,
                        hintText:
                        "Enter your Password",
                        textColor: Colors.white,
                        borderColor:
                        Colors.white.withOpacity(0.4),
                        obscureText:
                        _obscurePassword,
                        suffixIcon:
                        _obscurePassword
                            ? Icons
                            .visibility_off_outlined
                            : Icons
                            .visibility_outlined,
                        onSuffixIconPressed: () {
                          setState(() {
                            _obscurePassword =
                            !_obscurePassword;
                          });
                        },
                      ),

                      const SizedBox(height: 40),

                      state is LoginLoading
                          ? const Center(
                        child:
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          : AppButton(
                        textColor:
                        const Color(0xFF174944),
                        backgroundColor:
                        Colors.white,
                        height: 60,
                        text: "LOGIN",
                        onPressed: _login,
                      ),

                      const SizedBox(height: 18),

                      Align(
                        alignment:
                        Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            CustomSnackbar.info(
                              context,
                              "🔐 Password recovery coming soon!",
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}