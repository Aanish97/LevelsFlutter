import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Controllers/coach_controller/coach_controller.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/setting/profile_screen.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_icons.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/home/home_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/Sechudle/availability.dart';

import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';

class CoachBottomNavBar extends StatefulWidget {
  const CoachBottomNavBar({
    super.key,
  });

  @override
  CoachBottomNavBarState createState() => CoachBottomNavBarState();
}

class CoachBottomNavBarState extends State<CoachBottomNavBar> with TickerProviderStateMixin {
  // MotionTabBarController? _motionTabBarController;
  String profileImage = Constants.coachModel?.profileImage ?? '';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  CoachController controller = Get.put(CoachController());
  @override
  void initState() {
    super.initState();
    controller.motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0),
        child: AppBar(
            backgroundColor: Colors.transparent, // Set transparent color
            elevation: 0, // Remove elevation
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: height(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                        width: 60,
                                        height: 60,
                                      )
                                    : Image.asset(
                                        'assets/images/demo.png',
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WELCOME BACK',
                            style: montserratSemiBold.copyWith(
                                fontSize: 14, color: Colors.red),
                          ),
                          Text(
                              (Constants.isAthlete)
                                  ? Constants.athleteModel!.name.toString()
                                  : Constants.coachModel!.name.toString(),
                              style: montserratBold.copyWith(
                                  color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _storage.delete(key: 'type');
                      await _storage.delete(key: 'access_token');
                      await _storage.delete(key: 'userId');
                      Get.offAll(()=>const WelcomeScreen());
                    },
                    child: Image.asset(
                      AppIcons.menu,
                      height: 40,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: controller.motionTabBarController,
        initialSelectedTab: "Booking",
        useSafeArea: true,
        labels: const ["Booking", "Availability", "Settings"],
        icons: const [
          Icons.bookmark_add_outlined,
          // Icons.search,
          Icons.calendar_month_outlined,
          Icons.settings
        ],
        tabSize: 50,
        tabBarHeight: 50,
        textStyle: montserratMedium.copyWith(
          fontSize: 12,
          color: Colors.black,
        ),
        tabIconColor: AppColors.blackColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: AppColors.blackColor,
        tabIconSelectedColor: AppColors.primaryColor,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            controller.motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        // swipe navigation handling is not supported
        controller: controller.motionTabBarController,
        children: const <Widget>[
          HomeScreen(),
          // SearchScreen(),
          Availabilty(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
