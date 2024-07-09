import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/bottombar/AtheleteBottomBar.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/BottomBar/bottomNavBar.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');
  RxBool passwordVisible = true.obs;
  final secureStorage = const FlutterSecureStorage();
  AuthService authService = AuthService();
  RxBool loading = false.obs;

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  Future<String?> readKey(String key) async {
    String? value = await secureStorage.read(key: key);
    return value;
  }

  Future<void> authenticateUser(context) async {
    loading.value = true;
    update();
    final username = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      var tokens = await AuthService.getToken(username, password);
      if (tokens != null) {
        await secureStorage.write(key: 'access_token', value: tokens['access']);
        await secureStorage.write(key: 'refresh_token', value: tokens['refresh']);
        await secureStorage.write(key: 'type', value: tokens['type']);
        await secureStorage.write(key: 'userId', value: (tokens['user_id']).toString());
        String? accessToken = await readKey('access_token');
        Constants.accessToken = accessToken!;
        print("HERE IS THE ACCESS TOKE ${accessToken}");
        if (tokens['type'] == 'athlete') {
          Constants.isAthlete = true;
          Constants.athleteModel = await authService.fetchAthleteDetails(tokens['access'], tokens['user_id']);
          update();
          if (Constants.coachModel != null || Constants.athleteModel != null) {
            Get.offAll(() => const AthleteBottomBar());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        } else {
          Constants.isAthlete = false;
          update();
          Constants.coachModel = await authService.fetchCoachDetails(tokens['access'], tokens['user_id']);
          if (Constants.coachModel != null || Constants.athleteModel != null) {
            Get.offAll(() => const CoachBottomNavBar());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
      update();
    }
  }
}
