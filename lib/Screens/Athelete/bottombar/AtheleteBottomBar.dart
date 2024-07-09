import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/settings/athlete_setting_screen.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/home/athlete_home_page.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/search/athlete_search_screen.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_icons.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/mybookings/mybooking.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';

class AthleteBottomBar extends StatefulWidget {
  const AthleteBottomBar({super.key});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<AthleteBottomBar> with TickerProviderStateMixin {
  AtheleteController controller = Get.put(AtheleteController());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String profileImage = Constants.athleteModel?.profileImage ?? '' ;

  @override
  void initState() {
    super.initState();
    controller.motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
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
                      Get.offAll(() => const WelcomeScreen());
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
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Home", "Search", "My Booking", "Settings"],
        icons: const [
          Icons.home,
          Icons.search,
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
          AthleteHomeScreen(),
          AthleteSearchScreen(),
          MyBookings(),
          SettingScreen(),
        ],
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({required this.iconData});

  IconData iconData;
}
