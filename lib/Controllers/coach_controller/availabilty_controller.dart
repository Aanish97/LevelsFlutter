import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:levels_athletes_coaches/constants.dart';

class AvailabiltyController extends GetxController {

  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  RxString sundayStartTime = "".obs;
  RxString sundayEndTime = "".obs;
  RxString mondayStartTime = "".obs;
  RxString mondayEndTime = "".obs;
  RxString tuesdayStartTime = "".obs;
  RxString tuesdayEndTime = "".obs;
  RxString wedStartTime = "".obs;
  RxString wedEndTime = "".obs;
  RxString thuStartTime = "".obs;
  RxString thuEndTime = "".obs;
  RxString friStartTime = "".obs;
  RxString friEndTime = "".obs;
  RxString satStartTime = "".obs;
  RxString satEndTime = "".obs;
  TextEditingController sundayStartController = TextEditingController();
  TextEditingController sundayEndController = TextEditingController();
  TextEditingController mondayStartController = TextEditingController();
  TextEditingController mondayEndController = TextEditingController();
  TextEditingController tuesdayStartController = TextEditingController();
  TextEditingController tuesdayEndController = TextEditingController();
  TextEditingController wednesdayStartController = TextEditingController();
  TextEditingController wednesdayEndController = TextEditingController();
  TextEditingController thursdayStartController = TextEditingController();
  TextEditingController thursdayEndController = TextEditingController();
  TextEditingController fridayStartController = TextEditingController();
  TextEditingController friEndController = TextEditingController();
  TextEditingController saturdayStartController = TextEditingController();
  TextEditingController saturdayEndController = TextEditingController();
  var loading=false.obs;

  Future<TimeOfDay?> showStartTimePicker(context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    return pickedTime;
  }

  String formatTime(TimeOfDay time) {
    // Format the time using 24-hour format
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  DateTime setTime(time){
    DateTime currentDate = DateTime.now();
    DateTime dateTimeWithSpecificTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      time.hour,
      time.minute,
    );
    return dateTimeWithSpecificTime;

  }

  Future<dynamic> setAvailabilty(data,BuildContext? context) async {
    loading.value=true;
    update();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constants.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('$serverUrl/booking/time-slots/'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    print("here is data ${data}");
    http.StreamedResponse response = await request.send();
    print("here is data ${response.statusCode}");
    if (response.statusCode == 200 ||response.statusCode == 201) {
      loading.value=false;
      update();

      Get.back();
      Get.back();
      Get.snackbar("Availability Set", "Your availability set successfully",colorText: Colors.white,backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,margin: const EdgeInsets.all(15));
    }
    else {
      loading.value=false;
      update();
      Get.snackbar("Error", "Unable to set your availability",colorText: Colors.white,backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,margin: const EdgeInsets.all(15));
      print("hadsa${response.reasonPhrase}");
    }
  }
}