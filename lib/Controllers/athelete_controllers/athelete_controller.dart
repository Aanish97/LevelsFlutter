import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:levels_athletes_coaches/constants.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class AtheleteController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchAllCoaches();
    print('Controller initialized');
  }
  DateTime? startDate;
  DateTime? endDate;
  var coachList = [].obs;
  var searchList = [].obs;
  var bookingList = [].obs;
  var coachTimeSlots = [].obs;
  var coachLoading = false.obs;
  var timeSlotsLoading = false.obs;
  var searchLoading = false.obs;
  MotionTabBarController? motionTabBarController;



  /// here is the api call for feching bookings

  Future<dynamic> fetchAllBookings() async {
    try {
      // coachLoading.value = true;
      // update();
      const String apiUrl = '$serverUrl/booking/bookings/';
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
        // coachLoading.value = false;
        // update();
      } else {
        // coachLoading.value = false;
        // update();
        debugPrint(
            "Failed to fetch coaches. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // coachLoading.value = false;
      // update();
      debugPrint("Error fetching athletes: $e");
    }
  }

  /// fetch all coaches
  Future<dynamic> fetchAllCoaches() async {
    try {
      coachLoading.value = true;
      update();
      const String apiUrl =
          '$serverUrl/auth/coach/?years_of_coaching=&sport=&gender=&location=';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Constants.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        coachList.clear();
        coachList.addAll(data['results']);
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


  Future<dynamic> searchCoaches(
  {
    sport,
    gender,
    location,
    years
}
      ) async {
    try {
      searchLoading.value = true;
      update();
      const String apiUrl =
          '$serverUrl/auth/coach/?years_of_coaching=&sport=&gender=&location=';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Constants.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        searchList.clear();
        searchList.addAll(data['results']);
        searchLoading.value = false;
        update();
      } else {
        searchLoading.value = false;
        update();
        debugPrint(
            "Failed to fetch coaches. Status code: ${response.statusCode}");
      }
    } catch (e) {
      searchLoading.value = false;
      update();
      debugPrint("Error fetching athletes: $e");
    }
  }

  /// fetch time slots
  Future<dynamic> fetchCoachesTimeSlots({
    id,
    startDate,
    endDate,
  }) async {

    print("here is time slot data $id ${startDate} ${endDate}");
    try {
      timeSlotsLoading.value = true;
      update();
      // 2024-02-01
      String apiUrl =
          '$serverUrl/booking/time-slot-days/?coach=$id&start_date=$startDate&end_date=$endDate';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Constants.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        timeSlotsLoading.value = false;
        update();
        var data = jsonDecode(response.body);
        /// Parse JSON data
        List<dynamic> dayIntervals = jsonDecode(response.body);
        /// Days to repeat
        var keys_done = {};
        for (var originalDay in dayIntervals) {
          if (keys_done.containsKey(originalDay['day'])) {
            keys_done[originalDay['day']]['intervals'].addAll(originalDay['intervals']);
          }
          else{
            keys_done[originalDay['day']] = originalDay;
          }
        }
        coachTimeSlots.clear();
        coachTimeSlots.addAll(keys_done.entries.map((entry) => entry.value).toList());
        update();

      } else {
        // coachLoading.value=false;
        update();
        debugPrint(
            "Failed to fetch coaches. Status code: ${response.statusCode}");
      }
    } catch (e) {
      timeSlotsLoading.value = false;
      update();
      debugPrint("Error fetching athletes: $e");
    }
  }


  /// Booking for coach api
  Future<dynamic>addBooking({
    coachId,
    startDate,
    endDate
}) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('$serverUrl/booking/bookings/'));
    request.body = json.encode({
      "coach": coachId,
      "start_time":"${startDate}Z",
      // "2024-02-01T18:30:00Z",
      "end_time": "${endDate}Z",
      // "2024-02-01T19:00:00Z"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      fetchAllBookings();
      Get.back();
      Get.back();
      Get.snackbar("Booked Successfully", "Timeslot booked with coach ",
          margin:const  EdgeInsets.all(15),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }
    else {
      Get.snackbar("Booking Failed", "TimeSlot already booked. Select another timeslot.",
          margin:const  EdgeInsets.all(15),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }

  }
}
