import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Controllers/coach_controller/coach_profile_controller.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:levels_athletes_coaches/widgets/profile_pic.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

import '../../../constants/app_icons.dart';
import '../../../constants/app_sizes.dart';
import '../../../widgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  CoachProfileController controller=Get.put(CoachProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
            backgroundColor: Colors.transparent, // Set transparent color
            elevation: 0, // Remove elevation
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios,size: 30,color: AppColors.whiteColor,),
            ),
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: height(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(),
                  Image.asset(
                    AppImages.appLogo,
                    width: 155,
                    height: 139,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      AppIcons.menu,
                      height: 28,
                    ),
                  )
                ],
              ),
            )),
      ),
      body: Obx(()=>Stack(
        children: [
          /// back ground image
          Positioned.fill(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.editProfileBg,
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
                color: const Color(0xff000000).withOpacity(0.6),
              )),
          SafeArea(
            child: Container(
              width: width(context),
              height: height(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                         Center(
                            child: Text(
                          'EDIT PROFILE',
                          style: montserratBold.copyWith(
                              fontSize: 22,
                            color: AppColors.blackColor,
                          ),
                        )),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfilePicWidget(
                          imagePath: controller.imageFile.value,
                          onClicked: () async {
                              await controller.pickImage(context);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputField(
                                  hintText: "Name",
                                  obscureText: false,
                                  onTap: (){

                                  },
                                  keyboardType: TextInputType.text,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.nameController,
                                  textFieldValidator: (value) {
                                    if (value == null) {
                                      return 'Please enter a valid Name';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              /// number
                              Text("Phone Number",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Phone',
                                  obscureText: false,
                                  onTap: (){

                                  },
                                  keyboardType: TextInputType.phone,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.phoneController,
                                  textFieldValidator: (value) {
                                    if (!Validators().validateNumber(
                                        controller.phoneController.text.trim())) {
                                      return 'Please enter a valid phone';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              /// email
                              Text("Email Address",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Email',
                                  obscureText: false,
                                  onTap: (){

                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.emailController,
                                  textFieldValidator: (value) {
                                    if (!Validators().validateEmail(
                                        controller.emailController.text.trim())) {
                                      return 'Please enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),

                              /// date of birth
                              Text("Birth Date",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Birth Date',
                                  obscureText: false,
                                  onTap: () async {
                                    await controller.selectDate(context);
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: GestureDetector(
                                    onTap: () async {
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.red,
                                    ),
                                  ),
                                  controller: controller.birthdayController,
                                  textFieldValidator: (value) {
                                    if (value == null) {
                                      return 'Please enter a valid date';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              /// hourly rate
                              Text("Hourly Rate",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Hourly Rate',
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.hourlyRateController,
                                  textFieldValidator: (value) {
                                    if (value == null) {
                                      return 'Please enter a hourly rate';
                                    } else {
                                      return null;
                                    }
                                  },
                                onTap: () {  },),
                              const SizedBox(
                                height: 10,
                              ),


                              /// year of coaching
                              Text("Years of Coaching",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Years of coaching',
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.yearsOfCoachingController,
                                textFieldValidator: (value) {
                                  if (value == null) {
                                    return 'Please enter a years of coaching';
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {  },),
                              const SizedBox(
                                height: 10,
                              ),

                              Text("Location",style: montserratSemiBold.copyWith(
                                  color: AppColors.blackColor
                              ),),
                              const SizedBox(height: 5,),
                              InputField(
                                  hintText: 'Location',
                                  obscureText: false,
                                  keyboardType: TextInputType.streetAddress,
                                  suffixIcon: const SizedBox(),
                                  maxLines: 4,
                                  minlines: 2,
                                  controller: controller.locationController,
                                textFieldValidator: (value) {
                                  if (value == null) {
                                    return 'Please enter a your location';
                                  } else {
                                    return null;
                                  }
                                }, onTap: () {  },),
                              const SizedBox(
                                height: 10,
                              ),
                              /// bio
                              CustomTextField(
                                  hintText: 'Bio',
                                  isObscure: false,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const SizedBox(),
                                  maxLines: 4,
                                  minLines: 2,
                                  controller: controller.bioController,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter your bio';
                                  } else {
                                    return null;
                                  }
                                },
                                  ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textColor: Colors.white,
                          title: 'SAVE CHANGES',
                          onTap: () async {
                            if (controller.formKey.currentState!.validate()) {
                              setState(() {
                                controller.loading.value = true;
                              });
                                CoachModel updateData = CoachModel(
                                  id: Constants.coachModel!.id,
                                  name:controller.nameController.text.trim(),
                                  email: controller.emailController.text.trim(),
                                  username:controller.emailController.text.trim(),
                                  phoneNumber:controller. phoneController.text.trim(),
                                  location: controller.locationController.text.trim(),
                                  hourlyRate: int.parse(controller.hourlyRateController.text),
                                  yearsOfCoaching: int.parse(controller.yearsOfCoachingController.text.trim()),
                                  yearsOfTraining: int.parse(controller.yearsOfTrainingController.text.trim()),
                                  // birthdate: controller.birthdayController.text,
                                );
                                AuthService authRepo = AuthService();
                                await controller.updateCoachDetails(updateData, controller.imageFile.value, Constants.accessToken);
                                Constants.coachModel =
                                    await authRepo.fetchCoachDetails(
                                        Constants.accessToken,
                                        Constants.coachModel!.id);
                                setState(() {
                                  controller.loading.value = false;
                                });
                            } else {
                              (ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('please fill all the details.'),
                                ),
                              ));
                            }
                          },
                          isTransparent: false,
                          height: 45,
                          child: controller.loading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
