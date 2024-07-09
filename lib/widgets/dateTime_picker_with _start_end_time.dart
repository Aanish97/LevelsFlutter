import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/widgets/custom_radio_button.dart';

class DayTimePicker extends StatefulWidget {
  TextEditingController startTime;
  TextEditingController endTime;
  String? DayName;
  bool? isActive;
  final String? Function(String?)? startValidator;
  final String? Function(String?)? endValidator;
  VoidCallback? onRadioTap;
  VoidCallback? startTap;
  VoidCallback? endTap;

  DayTimePicker(
      {required this.DayName,
      required this.endTime,
      required this.startTime,
      required this.isActive,
      required this.startTap,
      required this.endTap,
        this.startValidator,
        this.endValidator,
      required this.onRadioTap,
      super.key});

  @override
  State<DayTimePicker> createState() => _DayTimePickerState();
}

class _DayTimePickerState extends State<DayTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width(context) * 0.19,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundCheckbox(
                value: widget.isActive!,
                onTap: widget.onRadioTap!,
              ),
              SizedBox(
                width: width(context) * 0.1,
                child: Text(
                  widget.DayName!,
                  style: montserratBold.copyWith(
                      color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        widget.isActive!
            ? SizedBox(
                width: width(context) * 0.63,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// start Time
                    SizedBox(
                        width: width(context) * 0.28,
                        height: 40,
                        child: TextFormField(
                          onTap: widget.startTap,
                          controller: widget.startTime,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            fillColor: AppColors.whiteColor,
                            filled: true,
                            hintText: "Start Time",
                            hintStyle: montserratMedium.copyWith(
                                fontSize: 12, color: AppColors.blackColor),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                          ),
                          validator:widget.startValidator,
                          style:
                              montserratRegular.copyWith(color: Colors.black),
                        )),
                    Text(
                      "To",
                      style: montserratBold.copyWith(color: Colors.white),
                    ),

                    /// end time
                    SizedBox(
                        width: width(context) * 0.28,
                        height: 40,
                        child: TextFormField(
                          onTap: widget.endTap,
                          controller: widget.endTime,
                          readOnly: true,
                          validator: widget.endValidator,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            fillColor: AppColors.whiteColor,
                            filled: true,
                            hintText: "End Time",
                            hintStyle: montserratMedium.copyWith(
                                fontSize: 12, color: AppColors.blackColor),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                // border color
                                width: 1.0, // border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // border radius
                            ),
                          ),
                          style:
                              montserratRegular.copyWith(color: Colors.black),
                        )),
                  ],
                ),
              )
            : SizedBox(
                width: width(context) * 0.63,
                child: Text(
                  "Closed",
                  style: montserratBold.copyWith(
                      color: Colors.white, fontSize: 14),
                ),
              )
      ],
    );
  }
}
