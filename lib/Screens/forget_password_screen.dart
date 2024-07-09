import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.loginBg), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            SafeArea(
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            Expanded(
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
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Center(
                              child: Text(
                            'Forget Password',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 25,
                          ),
                          Form(
                            key: _formKey,
                            child: InputField(
                                hintText: 'Email',
                                onTap: (){

                                },
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: const SizedBox(),
                                controller: emailController,
                                textFieldValidator: (value) {
                                  if (!Validators().validateEmail(
                                      emailController.text.trim())) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            textColor: Colors.white,
                            title: 'Submit',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // AuthService.sendPasswordResetEmail(
                                //     emailController.text);
                              }
                            },
                            isTransparent: false,
                            height: 55,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
