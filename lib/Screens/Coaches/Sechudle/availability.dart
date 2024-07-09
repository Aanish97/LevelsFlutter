import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/Sechudle/timeSlots.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';

class Availabilty extends StatefulWidget {
  const Availabilty({super.key});

  @override
  State<Availabilty> createState() => _AvailabiltyState();
}

class _AvailabiltyState extends State<Availabilty> {
  String? selectedOption;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController days=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  AppImages.availAbility,
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
                    color: const Color(0xff000000).withOpacity(0.01),
                  )),
              SafeArea(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: height(context) * 0.4,
                    width: width(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// set availability
                        Text(
                          "SET AVAILABILITY",
                          style: montserratBold.copyWith(
                              color: Colors.white, fontSize: 20),
                        ),

                        /// availability sub heading
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        Text(
                          "Set your schedule",
                          style: montserratMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),

                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                        /// selected day
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                                activeColor: AppColors.primaryColor,
                                value: "option 1",
                                groupValue: selectedOption,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return AppColors
                                          .primaryColor; // Color when disabled
                                    }
                                    return AppColors
                                        .primaryColor!; // Use default color if not disabled
                                  },
                                ),
                                onChanged: (val) {
                                  selectedOption = val;
                                  setState(() {});
                                }),

                            /// text filed
                            SizedBox(
                                width: 70,
                                height: 40,
                                child: TextFormField(
                                  controller: days,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.primaryColor,
                                        // border color
                                        width: 1.0, // border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // border radius
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.primaryColor,
                                        // border color
                                        width: 1.0, // border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // border radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.primaryColor,
                                        // border color
                                        width: 1.0, // border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // border radius
                                    ),
                                  ),
                                  style: montserratRegular.copyWith(
                                      color: Colors.white),
                                )),
                            SizedBox(
                              width: width(context) * 0.03,
                            ),
                            Container(
                              height: 40,
                              width: width(context) * 0.52,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Center(
                                child: Text(
                                  "Calendar days",
                                  style: montserratBold.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                        /// range picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                                activeColor: AppColors.primaryColor,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return AppColors
                                          .primaryColor; // Color when disabled
                                    }
                                    return AppColors
                                        .primaryColor!; // Use default color if not disabled
                                  },
                                ),
                                value: 'option 2',
                                groupValue: selectedOption,
                                onChanged: (val) {
                                  selectedOption = val;
                                  showCustomDateRangePicker(
                                    context,
                                    dismissible: true,
                                    minimumDate: DateTime.now().subtract(const Duration(days: 30)),
                                    maximumDate: DateTime.now().add(const Duration(days: 150)),
                                    endDate: endDate,
                                    startDate: startDate,
                                    backgroundColor: Colors.white,
                                    primaryColor: AppColors.primaryColor,
                                    onApplyClick: (start, end) {
                                      setState(() {
                                        endDate = end;
                                        startDate = start;
                                      });
                                    },
                                    onCancelClick: () {
                                      setState(() {
                                        endDate = null;
                                        startDate = null;
                                      });
                                    },
                                  );
                                  setState(() {});
                                }
                                ),
                            Container(
                              height: 40,
                              width: width(context) * 0.74,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Center(
                                child: Text(
                                  endDate==null?"Within date range":"${DateFormat.yMMMd().format(startDate!)} - ${DateFormat.yMMMd().format(endDate!)}",
                                  style: montserratBold.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                                activeColor: AppColors.primaryColor,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return AppColors
                                          .primaryColor; // Color when disabled
                                    }
                                    return AppColors
                                        .primaryColor!; // Use default color if not disabled
                                  },
                                ),
                                value: 'option 3',
                                groupValue: selectedOption,
                                onChanged: (val) {
                                  selectedOption = val;
                                  showCustomDateRangePicker(
                                    context,
                                    dismissible: true,
                                    minimumDate: DateTime.now().subtract(const Duration(days: 30)),
                                    maximumDate: DateTime.now().add(const Duration(days: 150)),
                                    endDate: endDate,
                                    startDate: startDate,
                                    backgroundColor: Colors.white,
                                    primaryColor: AppColors.primaryColor,
                                    onApplyClick: (start, end) {
                                      setState(() {
                                        endDate = end;
                                        startDate = start;
                                      });
                                    },
                                    onCancelClick: () {
                                      setState(() {
                                        endDate = null;
                                        startDate = null;
                                      });
                                    },
                                  );
                                  setState(() {});
                                }
                                ),
                            Container(
                              height: 40,
                              width: width(context) * 0.74,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Center(
                                child: Text(
                                  "Indefinitely into the future",
                                  style: montserratBold.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height(context)*0.15,
                left: 30,
                right: 30,
                child: CustomButton(
                    title: "Next",
                    onTap: () {
                      if(selectedOption==null){
                        Get.snackbar("Option Required", "Please select option",
                            backgroundColor: AppColors.primaryColor,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10)

                        );
                      }else{
                        if(selectedOption!.contains("1")){

                          if(days.text.trim().isEmpty){
                            Get.snackbar("Days Required", "Please enter days",
                                backgroundColor: AppColors.primaryColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10)

                            );
                          }else{
                            print("am in 1 ${DateTime.now().toIso8601String()}");
                            startDate=DateTime.now();
                            var Days=int.parse(days.text);
                            endDate=DateTime.now().add(Duration(days:Days));
                            print("am in 1 ${startDate}  ${endDate}");
                            Get.to(()=> TimeSlots(
                              startDate: startDate,
                              endDate: endDate,
                            ));
                          }

                        }else {
                          Get.to(()=> TimeSlots(
                            startDate: startDate,
                            endDate: endDate,
                          ));
                        }

                      }
                      print("here is radio button$selectedOption");
                    },
                    isTransparent: false,
                    textColor: AppColors.whiteColor,
                    height: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
