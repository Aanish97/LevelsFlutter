import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/login_screen.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/signup_screen.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// back ground image
            Positioned.fill(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                AppImages.background1,
                width: height(context) * 0.280,
                height: height(context) * 0.280,
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
                  color: const Color(0xff000000).withOpacity(0.7),
                )),

            Positioned(
              top: height(context) * 0.17,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    width: 289,
                    height: 259,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37.0),
                    child: CustomButton(
                      textColor: Colors.white,
                      title: 'SIGN UP',
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SignUpScreen()));
                        Get.to(() => const SignUpScreen());
                      },
                      isTransparent: false,
                      height: 55,
                      fontSize: kFont14,
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37.0),
                    child: CustomButton(
                      textColor: Colors.white,
                      title: 'LOGIN',
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginScreen()));
                        Get.to(() => const LoginScreen());
                      },
                      fontSize: kFont14,
                      buttonColor: Colors.black26,
                      isTransparent: false,
                      height: 55,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
