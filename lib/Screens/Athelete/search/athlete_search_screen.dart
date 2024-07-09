import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_icons.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_text_field.dart';

import '../home/widgets/search_result_athlete_screen.dart';

class AthleteSearchScreen extends StatefulWidget {
  const AthleteSearchScreen({super.key});

  @override
  State<AthleteSearchScreen> createState() => _AthleteSearchScreenState();
}

class _AthleteSearchScreenState extends State<AthleteSearchScreen> {
  final TextEditingController location = TextEditingController(text: '');
  final TextEditingController coachingYears = TextEditingController(text: '');
  var selectedGender = "";
  var selectedSport = "";
  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel?.profileImage ?? ''
      : Constants.coachModel?.profileImage ?? '';
  AtheleteController controller = Get.put(AtheleteController());
  var gender = ["Male", 'Female', 'other'];
  var sports = ["Boxing", 'MMA', 'Jiu-jitsu'];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// back ground image
              Positioned.fill(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.asset(
                  AppImages.backgroundImage,
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
                    color: const Color(0xff000000).withOpacity(0.8),
                  )),
              Positioned(
                top: height(context) * 0.15,
                left: 30,
                bottom: 0,
                right: 30,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height(context) * 0.15,
                      ),
                      Container(
                        height: height(context) * 0.09,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppIcons.coaches,
                              height: 46,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "COACHES",
                              style: montserratBold.copyWith(
                                fontSize: kFont14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.02,
                      ),
                      /// location controller
                      CustomTextField(
                          controller: location,
                          suffixIcon: const Icon(
                            Icons.location_pin,
                            color: AppColors.primaryColor,
                          ),
                          hintText: 'Location'),

                      /// sport button is here
                      SizedBox(
                        height: height(context) * 0.015,
                      ),
                      SizedBox(
                        height: 50,
                        width: width(context),
                        child: DropdownButtonFormField<String>(
                          value: selectedSport.isEmpty ? null : selectedSport,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            filled: true,
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            fillColor: AppColors.textFieldFillColor,
                          ),
                          hint: Text(
                            'Select Sport',
                            style: montserratRegular.copyWith(
                              color: AppColors.hintTextColor.withOpacity(0.7),
                              fontSize: kFont14,
                            ),
                          ),
                          style: montserratBold.copyWith(
                            color: AppColors.blackColor,
                            fontSize: kFont14,
                          ),
                          isExpanded: false,
                          dropdownColor: AppColors.whiteColor,
                          onChanged: (String? newValue) {
                            selectedSport = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select country';
                            }
                            return null;
                          },
                          items: sports
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: montserratMedium.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: kFont14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.015,
                      ),

                      /// location controller
                      CustomTextField(
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: coachingYears, hintText: 'Years of Coaching'),

                      /// gender
                      SizedBox(
                        height: height(context) * 0.015,
                      ),
                      SizedBox(
                        height: 50,
                        width: width(context),
                        child: DropdownButtonFormField<String>(
                          value: selectedGender.isEmpty ? null : selectedGender,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius10),
                            ),
                            filled: true,
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            fillColor: AppColors.textFieldFillColor,
                          ),
                          hint: Text(
                            'Gender',
                            style: montserratRegular.copyWith(
                              color: AppColors.hintTextColor.withOpacity(0.7),
                              fontSize: kFont14,
                            ),
                          ),
                          style: montserratBold.copyWith(
                            color: AppColors.blackColor,
                            fontSize: kFont14,
                          ),
                          isExpanded: false,
                          dropdownColor: AppColors.whiteColor,
                          onChanged: (String? newValue) {
                            selectedGender = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select country';
                            }
                            return null;
                          },
                          items: gender
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: montserratMedium.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: kFont14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      /// search button isher her
                      SizedBox(
                        height: height(context) * 0.015,
                      ),
                      CustomButton(
                        textColor: Colors.white,
                        title: 'SEARCH',
                        onTap: () async {
                           controller.searchCoaches(
                            gender:selectedGender ,
                            location:location.text.trim() ,
                            sport:selectedSport,
                            years:coachingYears.text.trim(),
                          );
                          Get.to(()=>const SearchResultAthleteScreen());
                        },
                        isTransparent: false,
                        height: 55,
                        child: controller.searchLoading.value
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              //Search
              // const SearchResultCoachScreen()
            ],
          ),
        ),
      ),
    );
  }
}
