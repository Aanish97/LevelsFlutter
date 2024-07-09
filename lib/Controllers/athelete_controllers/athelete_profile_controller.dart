import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/constants.dart';

import 'package:levels_athletes_coaches/models/user_model.dart';

class AtheleteProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.name
          : Constants.coachModel!.name);
  final TextEditingController phoneController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.phoneNumber
          : Constants.coachModel!.phoneNumber);
  final TextEditingController emailController = TextEditingController(text: Constants.isAthlete ? Constants.athleteModel!.email : Constants.coachModel!.email);
  final TextEditingController birthdayController = TextEditingController(text: Constants.isAthlete ? Constants.athleteModel!.birthdate : Constants.coachModel!.birthdate != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.birthdate!) : '');
  final TextEditingController locationController = TextEditingController(text: Constants.isAthlete ? Constants.athleteModel!.location : Constants.coachModel!.location);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        debugPrint('Selected Date: $formattedDate');
        birthdayController.text = formattedDate;
    }
  }

  RxString imageFile = "".obs;

  /// image picker
  Future<void> pickImage(context) async {
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        File file = File(result.files.single.path!);
        imageFile.value = file.path;

      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// upload Profile image

  uploadProfileImage(iD) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',};
    var request = http.MultipartRequest('PATCH', Uri.parse('$serverUrl/auth/athlete/$iD/'));
    request.files.add(await http.MultipartFile.fromPath('profile_image', '$imageFile'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Get.snackbar("Profile Image", "Profile image updated successfully",
      //     margin:const  EdgeInsets.all(15),
      //     backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }
    else {
    if (kDebugMode) {
      print(response.reasonPhrase);
    }
    }

  }

  Future<void> updateAthleteDetails(AthleteModel updatedAthlete, String imagePath, String accessToken) async {
    debugPrint(updatedAthlete.id.toString());

    final String apiUrl = '$serverUrl/auth/athlete/${updatedAthlete.id}/';
    try {
      loading.value=true;
      update();
      var request = http.MultipartRequest(
        "PATCH",
        Uri.parse(apiUrl),
      );
      request.fields.addAll(updatedAthlete.toJsonString());
      if (imagePath.isNotEmpty) {
       await  uploadProfileImage(updatedAthlete.id);
      }
      print("asdjasjkda${request.fields}");
      request.headers.addAll(<String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
      request.send().then((response) async {
        if (response.statusCode == 200) {
          loading.value=false;
          update();
          Get.snackbar("Profile Update", "Profile updated successfully",
              margin:const  EdgeInsets.all(15),
              backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Error ", "Failed to update profile data",
              margin:const  EdgeInsets.all(15),
              backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
        }
      });
    } catch (e) {
      loading.value=false;
      update();
      debugPrint('Error updating coach details: $e');
    }
  }
}