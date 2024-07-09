import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/forget_password_screen.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/custom_text_field.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

import 'package:levels_athletes_coaches/Controllers/auth_controller/logincontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Obx(()=>SingleChildScrollView(
        child: SizedBox(
          height: height(context),
          child: Stack(
            children: [
              /// bg image
              Positioned.fill(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.loginBg,
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),

              /// front shadow
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    color: const Color(0xff000000).withOpacity(0.4),
                  )),

              /// logo is here
              Positioned(
                top: height(context) * 0.08,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.appLogo,
                  height: 210,
                  width: 210,
                ),
              ),

              /// data shown here
              Positioned(
                top: height(context) * 0.43,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Center(
                            child: Text(
                          'Login',
                          style: montserratBold.copyWith(
                            color: AppColors.blackColor,
                            fontSize: kFont28,
                          ),
                        )),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  hintText: 'Email',
                                  isObscure: false,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.emailController,
                                  validator: (value) {
                                    if (!Validators().validateEmail(
                                        controller.emailController.text.trim())) {
                                      return 'Please enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              CustomTextField(
                                  hintText: 'Password',
                                  isObscure: controller.passwordVisible.value,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    splashRadius: 1,
                                    icon: Icon(!controller.passwordVisible.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: controller.togglePassword,
                                  ),
                                  controller: controller.passwordController,
                                  validator: (value) {
                                    if (!Validators().validatePassword(
                                        controller.passwordController.text.trim())) {
                                      return 'Please enter a valid password';
                                    } else {
                                      return null;
                                    }
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(const ForgotPasswordPage());
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textColor: Colors.white,
                          title: 'LOGIN',
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.authenticateUser(context);
                            }
                          },
                          isTransparent: false,
                          height: 55,
                          child: controller.loading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
