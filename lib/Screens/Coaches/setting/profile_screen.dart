import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/setting/edit_profile.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

import 'package:levels_athletes_coaches/Controllers/coach_controller/coach_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  CoachController controller = Get.put(CoachController());
  List<String> images = [
    AppImages.backgroundImage,
    AppImages.backgroundImage,
    AppImages.backgroundImage
  ];

  Future<void> clearUserData() async {
    await _storage.delete(key: 'type');
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'userId');
  }

  String profileImage = Constants.coachModel!.profileImage!;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: SizedBox(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(
                    height: height(context)/7,
                    width: width(context),
                  ),

                  SizedBox(
                    height: height(context)*0.03,
                  ),
                  /// edit profile  button is here
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        title: 'Edit Profile',
                        onTap: () async {
                          Get.to(()=>const EditProfile());
                        },

                        isTransparent: true,
                        fontSize: 16,
                        textColor: Colors.white,
                        height: 50),
                  ),
                  SizedBox(
                    height: height(context)*0.03,
                  ),
                  /// Mu bOOKINS button is here
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        title: 'My Bookings',
                        onTap: () async {
                          controller.motionTabBarController!.index=0;
                          setState(() {

                          });
                        },

                        isTransparent: true,
                        fontSize: 16,
                        textColor: Colors.white,
                        height: 50),
                  ),
                  SizedBox(
                    height: height(context)*0.03,
                  ),
                  /// reset password button is here
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        title: 'Reset Password',
                        onTap: () async {
                        },
                        isTransparent: true,
                        fontSize: 16,
                        textColor: Colors.white,
                        height: 50),
                  ),
                  SizedBox(
                    height: height(context)*0.03,
                  ),
                  /// Delete Account  button is here
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        title: 'Delete Account',
                        onTap: () async {
                          await clearUserData();
                          Get.offAll(()=>const WelcomeScreen());
                        },
                        isTransparent: true,
                        fontSize: 16,
                        textColor: Colors.white,
                        height: 50),
                  ),
                  SizedBox(
                    height: height(context)*0.03,
                  ),
                  /// logout button is here
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        title: 'Logout',
                        onTap: () async {
                          await clearUserData();
                        Get.offAll(()=>const WelcomeScreen());
                        },
                        isTransparent: false,
                        fontSize: 18,
                        textColor: Colors.white,
                        height: 50),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
