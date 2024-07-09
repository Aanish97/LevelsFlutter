import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/settings/reset_password.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/settings/athlete_edit_profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

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
  AtheleteController controller = Get.put(AtheleteController());
  String profileImage =Constants.athleteModel!.profileImage!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: height(context),
        child: Stack(
          children: [
            /// back ground image
            Positioned.fill(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                AppImages.settingBg,
                height: height(context),
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
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal:width(context)*0.08,vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: height(context) * 0.15,
                    ),
                    /// My Bookings
                    CustomButton(
                        title: "My Bookings",
                        onTap: () {
                          controller.motionTabBarController!.index=2;
                          setState(() {

                          });
                        },
                        isTransparent: true,
                        textColor: AppColors.whiteColor,
                        height: 55),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    /// edit profile
                    CustomButton(
                        title: "Edit Profile",
                        onTap: () {
                          Get.to(()=>const AthleteEditProfile());
                        },
                        isTransparent: true,
                        textColor: AppColors.whiteColor,
                        height: 55),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    /// view certificate
                    CustomButton(
                        title: "View Certificate",
                        onTap: () {
                          Get.to(()=>const AthleteEditProfile());
                        },
                        isTransparent: true,
                        textColor: AppColors.whiteColor,
                        height: 55),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    /// reset password
                    CustomButton(
                        title: "Reset Password",
                        onTap: () {
                          Get.to(()=>const ResetPasswordPage());
                        },
                        isTransparent: true,
                        textColor: AppColors.whiteColor,
                        height: 55),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    // Container(
                    //   height: 130,
                    //   width: MediaQuery.of(context).size.width * 0.8,
                    //   decoration: BoxDecoration(
                    //     color: Colors.black.withOpacity(0.8),
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         Constants.athleteModel!.name,
                    //         style: const TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 18),
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       richText('Date Joined: ',
                    //           "${Constants.isAthlete ? DateFormat('yyyy-MM-dd').format(Constants.athleteModel!.dateJoined) : (Constants.coachModel?.dateJoined != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.dateJoined!) : '')}"),
                    //       // richText(
                    //       //     'Training Jui-Jitsu since: ', '2023'),
                    //       // richText('Attainment: ', 'Black Belt'),
                    //       richText('Gym(s): ',
                    //           "${Constants.isAthlete ? Constants.athleteModel!.location : Constants.coachModel?.location}"),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: height(context) * 0.015,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   width: MediaQuery.of(context).size.width * 0.8,
                    //   decoration: BoxDecoration(
                    //     color: Colors.black.withOpacity(0.8),
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           'UPLOAD CONTENT',
                    //           style: montserratBold.copyWith(
                    //               color: Colors.white, fontSize: 18),
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Container(
                    //           decoration: BoxDecoration(
                    //               color: Colors.grey,
                    //               borderRadius: BorderRadius.circular(10)),
                    //           child: ListTile(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10)),
                    //             leading: const Icon(
                    //               Icons.restore_page,
                    //               color: Colors.white,
                    //             ),
                    //             title: const Text(
                    //               'Certificate 01',
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //             trailing: Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.grey.shade600,
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //                 padding: const EdgeInsets.all(5),
                    //                 child: const Icon(
                    //                   Icons.delete,
                    //                   color: Colors.black,
                    //                 )),
                    //             onTap: () async {},
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         Container(
                    //           decoration: BoxDecoration(
                    //               color: Colors.grey,
                    //               borderRadius: BorderRadius.circular(10)),
                    //           child: ListTile(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10)),
                    //             leading: const Icon(
                    //               Icons.restore_page,
                    //               color: Colors.white,
                    //             ),
                    //             title: const Text(
                    //               'Certificate 02',
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //             trailing: Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.grey.shade600,
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //                 padding: const EdgeInsets.all(5),
                    //                 child: const Icon(
                    //                   Icons.delete,
                    //                   color: Colors.black,
                    //                 )),
                    //             onTap: () {},
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         Wrap(
                    //           spacing: 8,
                    //           children: images
                    //               .map(
                    //                 (image) => Stack(
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           vertical: 8.0),
                    //                       child: ClipRRect(
                    //                         borderRadius:
                    //                             BorderRadius.circular(5),
                    //                         child: SizedBox(
                    //                           width: 80,
                    //                           height: 70,
                    //                           child: Image.asset(image,
                    //                               fit: BoxFit.cover),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Positioned(
                    //                       top: 2,
                    //                       right: 2,
                    //                       child: GestureDetector(
                    //                         onTap: () {},
                    //                         child: Container(
                    //                             decoration: BoxDecoration(
                    //                               color: Colors.grey.shade600,
                    //                               shape: BoxShape.circle,
                    //                             ),
                    //                             padding:
                    //                                 const EdgeInsets.all(5),
                    //                             child: const Icon(
                    //                               Icons.delete,
                    //                               color: Colors.black,
                    //                               size: 12,
                    //                             )),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               )
                    //               .toList(),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: height(context) * 0.03,
                    // ),
                    /// logout button is here
                    CustomButton(
                        title: 'Logout',
                        onTap: () async {
                          await clearUserData();
                          Get.offAll(() => const WelcomeScreen());
                        },
                        isTransparent: false,
                        textColor: Colors.white,
                        height: 50),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
