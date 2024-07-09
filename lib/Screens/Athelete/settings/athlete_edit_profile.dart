import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_profile_controller.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/custom_text_field.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:levels_athletes_coaches/widgets/profile_pic.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_icons.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';

class AthleteEditProfile extends StatefulWidget {
  const AthleteEditProfile({
    super.key,
  });

  @override
  State<AthleteEditProfile> createState() => _AthleteEditProfileState();
}

class _AthleteEditProfileState extends State<AthleteEditProfile> {

  AtheleteProfileController controller=Get.put(AtheleteProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
            backgroundColor: Colors.transparent, // Set transparent color
            elevation: 0, // Remove elevation
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
      body: Stack(
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
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                        Center(
                            child: Text(
                          'EDIT PROFILE',
                          style: montserratBold.copyWith(
                            fontSize: 24,
                          ),
                        )),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                        /// profile image
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: ProfilePicWidget(
                            imagePath: controller.imageFile.value,
                            onClicked: (){
                              controller.pickImage(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
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
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              CustomTextField(
                                  hintText: 'Phone',
                                  isObscure: false,
                                  keyboardType: TextInputType.phone,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.phoneController,
                                  validator: (value) {
                                    if (!Validators().validateNumber(
                                        controller.phoneController.text.trim())) {
                                      return 'Please enter a valid phone';
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              CustomTextField(
                                  hintText: 'Email',
                                  isObscure: false,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const SizedBox(),
                                  controller: controller.emailController,
                                  validator: (value) {
                                    if (!Validators().validateEmail(
                                        controller.emailController.text.trim())) {
                                      return 'Please enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              InputField(
                                  hintText: 'Birth Date',
                                  obscureText: false,
                                  readOnly:true,
                                  onTap: () async {
                                    var result = await controller.selectDate(context);
                                  },
                                  keyboardType: TextInputType.text,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.red,
                                  ),
                                  controller: controller.birthdayController,
                                  textFieldValidator: (value) {
                                    if (value == null) {
                                      return 'Please enter a valid date';
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        CustomButton(
                          textColor: Colors.white,
                          title: 'SAVE CHANGES',
                          onTap: () async {
                            if (controller.formKey.currentState!.validate()) {
                              AthleteModel updateData = AthleteModel(
                                id: Constants.athleteModel!.id,
                                name: controller.nameController.text.trim(),
                                email: controller.emailController.text.trim(),
                                username: controller.emailController.text.trim(),
                                phoneNumber: controller.phoneController.text.trim(),
                                location: controller.locationController.text.trim(),
                                gender: "",
                                //just values
                                firstName: '',
                                lastName: '',

                                isSuperuser: false,
                                isStaff: false,
                                isActive: true,
                                dateJoined: DateTime.timestamp(),
                                groups: [],
                                userPermissions: [],
                                bio: '',
                                lastLogin: DateTime.timestamp(),
                                password: '',
                                birthdate: controller.birthdayController.text,
                                profileImage: '',
                              );
                              AuthService authRepo = AuthService();
                              print("here is update ${updateData.birthdate}");
                              // await controller.updateAthleteDetails(updateData, controller.imageFile.value, Constants.accessToken);
                              Constants.athleteModel = await authRepo.fetchAthleteDetails(Constants.accessToken, Constants.athleteModel!.id);
                            }
                            else {
                              (ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('please fill all the details.'),
                                ),
                              ));
                            }
                          },
                          isTransparent: false,
                          height: 50,
                          child: controller.loading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
