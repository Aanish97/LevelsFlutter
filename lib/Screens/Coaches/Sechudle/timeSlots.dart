import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Controllers/coach_controller/availabilty_controller.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/dateTime_picker_with%20_start_end_time.dart';

import 'package:levels_athletes_coaches/widgets/custom_button.dart';

class TimeSlots extends StatefulWidget {
  DateTime? startDate;
  DateTime? endDate;

  TimeSlots({required this.startDate, required this.endDate, super.key});

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  AvailabiltyController controller = AvailabiltyController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent, // Set transparent color
            elevation: 0, // Remove elevation
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: height(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
            )),
      ),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Form(
          key: formKey,
          child: Stack(
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
              SafeArea(
                child: Center(
                  child: Container(
                    height: height(context) * 0.62,
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 0,
                        bottom: height(context) * 0.09),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xff000000),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          "Set your available hours",
                          style: montserratMedium.copyWith(
                              color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// availability sub heading
                        SizedBox(
                          height: height(context) * 0.01,
                        ),

                        ///sunday
                        DayTimePicker(
                          DayName: "Sun",
                          startTime: controller.sundayStartController,
                          endTime: controller.sundayEndController,
                          isActive: controller.sunday,
                          onRadioTap: () {
                            controller.sunday = !controller.sunday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);
                              // print("here is result date ${result.format(context).toString()}");
                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              print("here is date ${formattedDate}Z");
                              controller.sundayStartTime.value = formattedDate;
                              controller.sundayStartController.text = controller.formatTime(result);
                              print("here is result date ${controller.sundayStartController.text}");
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.sundayEndTime.value =formattedDate;
                              controller.sundayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// Monday
                        DayTimePicker(
                          DayName: "Mon",
                          startTime: controller.mondayStartController,
                          endTime: controller.mondayEndController,
                          isActive: controller.monday,
                          onRadioTap: () {
                            controller.monday = !controller.monday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.mondayStartTime.value = formattedDate;
                              controller.mondayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                                await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.mondayEndTime.value = formattedDate;
                              controller.mondayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// tuesday
                        DayTimePicker(
                          DayName: "Tue",
                          startTime: controller.tuesdayStartController,
                          endTime: controller.tuesdayEndController,
                          isActive: controller.tuesday,
                          onRadioTap: () {
                            controller.tuesday = !controller.tuesday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.tuesdayStartTime.value = formattedDate;
                              controller.tuesdayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.tuesdayEndTime.value = formattedDate;
                              controller.tuesdayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// wednesday
                        DayTimePicker(
                          DayName: "Wed",
                          startTime: controller.wednesdayStartController,
                          endTime: controller.wednesdayEndController,
                          isActive: controller.wednesday,
                          onRadioTap: () {
                            controller.wednesday = !controller.wednesday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.wedStartTime.value = formattedDate;
                              controller.wednesdayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.wedEndTime.value = formattedDate;
                              controller.wednesdayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// thursday
                        DayTimePicker(
                          DayName: "Thu",
                          startTime: controller.thursdayStartController,
                          endTime: controller.thursdayEndController,
                          isActive: controller.thursday,
                          onRadioTap: () {
                            controller.thursday = !controller.thursday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.thuStartTime.value = formattedDate;
                              controller.thursdayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.thuEndTime.value = formattedDate;
                              controller.thursdayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// friday
                        DayTimePicker(
                          DayName: "Fri",
                          startTime: controller.fridayStartController,
                          endTime: controller.friEndController,
                          isActive: controller.friday,
                          onRadioTap: () {
                            controller.friday = !controller.friday;
                            setState(() {});
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);

                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.friStartTime.value = formattedDate;
                              controller.fridayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);
                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.friEndTime.value = formattedDate;
                              controller.friEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),

                        /// saturday
                        DayTimePicker(
                          DayName: "Sat",
                          startTime: controller.saturdayStartController,
                          endTime: controller.saturdayEndController,
                          isActive: controller.saturday,
                          onRadioTap: () {
                            controller.saturday = !controller.saturday;
                            setState(() {});
                          },
                          startTap: () async {
                            var result = await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);
                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.satStartTime.value = formattedDate;
                              controller.saturdayStartController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endTap: () async {
                            var result =
                            await controller.showStartTimePicker(context);
                            if (result != null) {
                              var dateTime = controller.setTime(result);
                              String formattedDate = '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateTime.toUtc() )}Z';
                              controller.satEndTime.value = formattedDate;
                              controller.saturdayEndController.text = controller.formatTime(result);
                              setState(() {});
                            }
                          },
                          endValidator: (value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                          startValidator:(value){
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            // You can add more complex validation logic here
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.015,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// submitButton is here
              Obx(()=>Positioned(
                bottom: height(context) * 0.08,
                left: 20,
                right: 20,
                child: CustomButton(
                    title: "Submit",
                    onTap: () async {
                      var jsonData =
                      {
                        "start_date": widget.startDate!.toString().split(" ").first,
                        "end_date": widget.endDate!.toString().split(" ").first,
                        "days": {
                          "monday":{
                            "start_time": controller.mondayStartController.text,
                            "end_time": controller.mondayEndController.text,
                            "is_booked": controller.monday?false:true,
                          },
                          "tuesday":{
                            "start_time": controller.tuesdayStartController.text,
                            "end_time": controller.tuesdayEndController.text,
                            "is_booked": controller.tuesday?false:true,
                          },
                          "wednesday":{
                            "start_time": controller.wednesdayStartController.text,
                            "end_time": controller.wednesdayEndController.text,
                            "is_booked": controller.wednesday?false:true,
                          },
                          "thursday":{
                            "start_time": controller.thursdayStartController.text,
                            "end_time": controller.thursdayEndController.text,
                            "is_booked": controller.thursday?false:true,
                          },
                          "friday":{
                            "start_time": controller.fridayStartController.text,
                            "end_time": controller.friEndController.text,
                            "is_booked": controller.friday?false:true,
                          },
                          "saturday":{
                            "start_time": controller.saturdayStartController.text,
                            "end_time": controller.saturdayEndController.text,
                            "is_booked": controller.saturday?false:true,
                          },
                          "sunday":{
                            "start_time": controller.sundayStartController.text,
                            "end_time": controller.sundayEndController.text,
                            "is_booked": controller.sunday?false:true,
                          },
                        },
                      };
                      await controller.setAvailabilty(jsonData,context);

                    },
                    isTransparent: false,
                    textColor: AppColors.whiteColor,
                    height: 50,
                    child: controller.loading.value?const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ):null
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
