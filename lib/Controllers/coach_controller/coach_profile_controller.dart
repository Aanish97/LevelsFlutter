 import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
 import 'package:http/http.dart' as http;
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';

class CoachProfileController extends GetxController{
  final TextEditingController nameController = TextEditingController(text:Constants.coachModel!.name);
  final TextEditingController bioController = TextEditingController(text:Constants.coachModel!.bio);
  final TextEditingController phoneController = TextEditingController(text:Constants.coachModel!.phoneNumber);
  final TextEditingController addressController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: Constants.coachModel!.email);
  final TextEditingController birthdayController = TextEditingController(text:Constants.coachModel!.birthdate != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.birthdate!) : '');
  final TextEditingController locationController = TextEditingController(text:Constants.coachModel!.location);
  final TextEditingController hourlyRateController = TextEditingController(text: Constants.coachModel!.hourlyRate.toString());
  final TextEditingController yearsOfTrainingController = TextEditingController(text:Constants.coachModel!.yearsOfTraining.toString());
  final TextEditingController yearsOfCoachingController = TextEditingController(text:Constants.coachModel!.yearsOfCoaching.toString());
  final TextEditingController availabilityController = TextEditingController(text: '');
  final TextEditingController bankDetailController = TextEditingController(text: '');
  RxBool loading = false.obs;
  DateTime? selectedDate;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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


  setData(){
     nameController.text = Constants.coachModel!.name!;
     bioController.text = Constants.coachModel!.bio!;
     phoneController.text = Constants.coachModel!.phoneNumber!;
     addressController.text =  '';
    emailController.text = Constants.coachModel!.email!;
    birthdayController.text = Constants.coachModel!.birthdate != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.birthdate!) : "";
     locationController.text = Constants.coachModel!.location!;
     hourlyRateController.text =  Constants.coachModel!.hourlyRate.toString()!;
     yearsOfTrainingController.text = Constants.coachModel!.yearsOfTraining.toString();
    yearsOfCoachingController.text = Constants.coachModel!.yearsOfCoaching.toString();
    availabilityController.text =  '';
     bankDetailController.text = '';
  }

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
    var request = http.MultipartRequest('PATCH', Uri.parse('$serverUrl/auth/coach/$iD/'));
    request.files.add(await http.MultipartFile.fromPath('profile_image', '$imageFile'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("hasdahdad profile image ${response.stream.toString()}");
    if (response.statusCode == 200) {
    }
    else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }

  }

  Future<void> updateCoachDetails(CoachModel updatedCoach, String imagePath, String accessToken) async {
    debugPrint(updatedCoach.id.toString());

    final String apiUrl = '$serverUrl/auth/coach/${updatedCoach.id}/';
    try {
      loading.value=true;
      update();
      var request = http.MultipartRequest(
        "PATCH",
        Uri.parse(apiUrl),
      );
      request.fields.addAll(updatedCoach.toJsonString());
      if (imagePath.isNotEmpty) {
        print("here is the id${updatedCoach.id}");
        await  uploadProfileImage(updatedCoach.id);
      }
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