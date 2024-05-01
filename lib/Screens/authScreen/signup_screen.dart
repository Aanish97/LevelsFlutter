import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/login_screen.dart';
import 'package:levels_athletes_coaches/Screens/select_sport_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/coach_provider.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';

import '../../Controllers/singupontroller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignupController auth = SignupController();

  @override
  Widget build(BuildContext context) {
    var coachProvider = Provider.of<CoachProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Obx(() => SingleChildScrollView(
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
                      AppImages.background2,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// logo is here
                  Positioned(
                    top: height(context) * 0.08,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppImages.appLogo,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Positioned(
                    top: height(context) * 0.31,
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              Center(
                                  child: Text('Are you an',
                                      style: montserratBold.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: kFont16,
                                      ))),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),

                              /// athlete and coach button is here
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 145,
                                    child: CustomButton(
                                      textColor:
                                          (auth.professionType == 'ATHLETE')
                                              ? Colors.white
                                              : Colors.black,
                                      title: 'ATHLETE',
                                      onTap: () {
                                        auth.setProfessionType('ATHLETE');
                                      },
                                      isTransparent:
                                          (auth.professionType == 'ATHLETE')
                                              ? false
                                              : true,
                                      height: 45,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 145,
                                    child: CustomButton(
                                      textColor:
                                          (auth.professionType == 'COACH')
                                              ? Colors.white
                                              : Colors.black,
                                      title: 'COACH',
                                      onTap: () {
                                        auth.setProfessionType('COACH');
                                      },
                                      isTransparent:
                                          (auth.professionType == 'COACH')
                                              ? false
                                              : true,
                                      height: 45,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              Center(
                                  child: Text('Fill out the details below:',
                                      style: montserratBold.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: kFont16,
                                      ))),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              Form(
                                key: auth.formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                        hintText: 'Name',
                                        isObscure: false,
                                        keyboardType: TextInputType.text,
                                        suffixIcon: const SizedBox(),
                                        controller: auth.nameController,
                                        validator: (value) {
                                          if (!Validators().validateName(auth
                                              .nameController.text
                                              .trim())) {
                                            return 'Please enter a valid Name';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: height(context) * 0.015,
                                    ),
                                    CustomTextField(
                                        hintText: 'Phone',
                                        keyboardType: TextInputType.phone,
                                        isObscure: false,
                                        suffixIcon: const SizedBox(),
                                        controller: auth.phoneNoController,
                                        validator: (value) {
                                          if (!Validators().validateNumber(auth
                                              .phoneNoController.text
                                              .trim())) {
                                            return 'Please enter a valid phone';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: height(context) * 0.015,
                                    ),
                                    CustomTextField(
                                        hintText: 'Email',
                                        isObscure: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        suffixIcon: const SizedBox(),
                                        controller: auth.emailController,
                                        validator: (value) {
                                          if (!Validators().validateEmail(auth
                                              .emailController.text
                                              .trim())) {
                                            return 'Please enter a valid email';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: height(context) * 0.015,
                                    ),
                                    CustomTextField(
                                        hintText: 'Password',
                                        isObscure: auth.passwordVisible.value,
                                        keyboardType: TextInputType.text,
                                        controller: auth.passwordController,
                                        suffixIcon: IconButton(
                                          color: Colors.black,
                                          splashRadius: 1,
                                          icon: Icon(!auth.passwordVisible.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                          onPressed: auth.togglePassword,
                                        ),
                                        validator: (value) {
                                          if (!Validators().validatePassword(
                                              auth.passwordController.text
                                                  .trim())) {
                                            return 'Please enter a valid password';
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: height(context) * 0.015,
                                    ),
                                    CustomTextField(
                                        hintText: 'Confirm Password',
                                        isObscure:
                                            auth.confirmPasswordVisible.value,
                                        keyboardType: TextInputType.text,
                                        suffixIcon: IconButton(
                                          color: Colors.black,
                                          splashRadius: 1,
                                          icon: Icon(!auth
                                                  .confirmPasswordVisible.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                          onPressed: auth.toggleConfirmPassword,
                                        ),
                                        controller:
                                            auth.confirmPasswordController,
                                        validator: (value) {
                                          if (auth.passwordController.text !=
                                              auth.confirmPasswordController
                                                  .text) {
                                            return 'Password is not match';
                                          } else {
                                            return null;
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),

                              /// submit button is here
                              CustomButton(
                                textColor: Colors.white,
                                title: 'SUBMIT',
                                onTap: () async {
                                  if (auth.professionType == 'ATHLETE') {
                                    if (auth.formKey.currentState!.validate()) {
                                      setState(() {
                                        auth.loading.value = true;
                                      });
                                      AthleteModel userData = AthleteModel(
                                        name: auth.nameController.text.trim(),
                                        email: auth.emailController.text.trim(),
                                        username:
                                            auth.emailController.text.trim(),
                                        password:
                                            auth.passwordController.text.trim(),
                                        phoneNumber:
                                            auth.phoneNoController.text.trim(),
                                        bio: '',
                                        birthdate: '',
                                        dateJoined: DateTime.timestamp(),
                                        firstName: '',
                                        lastName: '',
                                        location: '',
                                        isSuperuser: false,
                                        isStaff: false,
                                        isActive: true,
                                        groups: [],
                                        userPermissions: [],
                                        id: 0,
                                        profileImage: '',
                                      );
                                      bool isSignUp =
                                          await AuthService.createAthlete(
                                              userData);
                                      if (isSignUp) {
                                        setState(() {
                                          auth.loading.value = false;
                                        });
                                        Get.to(() => const LoginScreen());
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Something went wrong, try later!'),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    if (auth.formKey.currentState!.validate()) {
                                      CoachModel coach = CoachModel(
                                        name: auth.nameController.text.trim(),
                                        email: auth.emailController.text.trim(),
                                        password:
                                            auth.passwordController.text.trim(),
                                        phoneNumber:
                                            auth.phoneNoController.text.trim(),
                                        username:
                                            auth.emailController.text.trim(),
                                        firstName: '',
                                        lastName: '',
                                        location: '',
                                        isSuperuser: false,
                                        isStaff: false,
                                        isActive: true,
                                        dateJoined: DateTime.timestamp(),
                                        groups: [],
                                        userPermissions: [],
                                        answers: [],
                                        hourlyRate: 0,
                                        bio: '',
                                        birthdate: DateTime.timestamp(),
                                        lastLogin: DateTime.timestamp(),
                                        sportTypes: [],
                                        yearsOfCoaching: 0,
                                        yearsOfTraining: 0,
                                        professionalFighter: false,
                                      );
                                      coachProvider.setCoach(coach);
                                      Get.to(() => const SelectSport());
                                    }
                                  }
                                },
                                isTransparent: false,
                                height: 50,
                                child: auth.loading.value
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
