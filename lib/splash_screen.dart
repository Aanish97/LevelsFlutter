import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:levels_athletes_coaches/BottomBar/buttombar.dart';
import 'package:levels_athletes_coaches/Screens/welcome_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:lottie/lottie.dart';

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
    print(accessToken);
    if (type == 'athlete') {
      Constants.athleteModel = await authService.fetchAthleteDetails(
          accessToken!, int.parse(userId!));
      Constants.isAthlete = true;
      Constants.accessToken = accessToken;
    }
    if (type == 'coach') {
      Constants.coachModel =
          await authService.fetchCoachDetails(accessToken!, int.parse(userId!));
      Constants.isAthlete = false;
      Constants.accessToken = accessToken;
    }
    Future.delayed(const Duration(seconds: 2), () async {
      if (Constants.athleteModel != null || Constants.coachModel != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TabContainer()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(background1), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
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
        ),
      ),
    );
  }
}
