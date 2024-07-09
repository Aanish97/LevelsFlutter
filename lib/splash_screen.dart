import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/bottombar/AtheleteBottomBar.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/BottomBar/bottomNavBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();

  Future<String?> readKey(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() async {
    String? type = await readKey('type');
    String? accessToken = await readKey('access_token');
    String? userId = await readKey('userId');
    if (type == 'athlete') {
      Constants.athleteModel = await authService.fetchAthleteDetails(accessToken!, int.parse(userId!));
      Constants.isAthlete = true;
      Constants.accessToken = accessToken;
      Future.delayed(const Duration(seconds: 2), () async {
        if (Constants.athleteModel != null || Constants.coachModel != null) {
          Get.offAll(() => const AthleteBottomBar());
        } else {
          Get.offAll(() => const WelcomeScreen());
        }
      });
    }else
    if (type == 'coach') {
      Constants.coachModel =
          await authService.fetchCoachDetails(accessToken!, int.parse(userId!));
      Constants.isAthlete = false;
      Constants.accessToken = accessToken;
      Future.delayed(const Duration(seconds: 2), () async {
        if (Constants.athleteModel != null || Constants.coachModel != null) {
          Get.offAll(() => const CoachBottomNavBar());
        } else {
          Get.offAll(() => const WelcomeScreen());
        }
      });
    }else{
      Get.offAll(() => const WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
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
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Lottie.asset('assets/animation/loader.json',
                        width: 150, height: 150),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
