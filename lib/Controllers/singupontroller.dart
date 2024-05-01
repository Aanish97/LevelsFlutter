import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  String professionType = 'ATHLETE';
  RxBool passwordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;
  RxBool loading = false.obs;


  void setProfessionType(String type) {

      professionType = type;
      update();
  }

  void togglePassword() {
      passwordVisible.value = !passwordVisible.value;
      update();
  }

  void toggleConfirmPassword() {
      confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }
}