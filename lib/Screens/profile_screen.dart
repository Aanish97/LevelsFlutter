import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel!.profileImage!
      : Constants.coachModel!.profileImage!;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            Expanded(
                child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      Constants.isAthlete ? 'ATHLETE' : 'COACH',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        color: Colors.red,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: profileImage.isNotEmpty
                                  ? Image.network(
                                      insertAuthPath(profileImage),
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.asset(
                                      'assets/images/demo.png',
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${Constants.isAthlete ? Constants.athleteModel!.name : Constants.coachModel?.name}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            richText('Date Joined: ',
                                "${Constants.isAthlete ? DateFormat('yyyy-MM-dd').format(Constants.athleteModel!.dateJoined) : (Constants.coachModel?.dateJoined != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.dateJoined!) : '')}"),
                            // richText(
                            //     'Training Jui-Jitsu since: ', '2023'),
                            // richText('Attainment: ', 'Black Belt'),
                            richText('Gym(s): ',
                                "${Constants.isAthlete ? Constants.athleteModel!.location : Constants.coachModel?.location}"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    //         const Text(
                    //           'UPLOAD CONTENT',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomButton(
                          title: 'Logout',
                          onTap: () async {
                            await clearUserData();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WelcomeScreen()),
                                (Route<dynamic> route) => false);
                          },
                          isTransparent: false,
                          textColor: Colors.white,
                          height: 55),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
