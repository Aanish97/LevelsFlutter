import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:http/http.dart' as http;
import 'package:motion_tab_bar/MotionTabBarController.dart';
class CoachController extends GetxController{

  var bookingList=[].obs;
  var coachLoading=false.obs;
  MotionTabBarController? motionTabBarController;

  /// fecthing booking
  Future<dynamic> fetchAllBookings() async {
    try {
      // coachLoading.value = true;
      // update();
      const String apiUrl = '$serverUrl/booking/bookings/coach-bookings';
      print("here is the data${Constants.accessToken}");
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Constants.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        bookingList.addAll(data);
        coachLoading.value = false;
        update();
      } else {
        coachLoading.value = false;
        update();
        debugPrint(
            "Failed to fetch coaches. Status code: ${response.statusCode}");
      }
    } catch (e) {
      coachLoading.value = false;
      update();
      debugPrint("Error fetching athletes: $e");
    }
  }
}