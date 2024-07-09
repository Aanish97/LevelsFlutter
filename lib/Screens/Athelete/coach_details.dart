import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/booktime_screen.dart';

import '../../Controllers/athelete_controllers/athelete_controller.dart';

class CoachDetailsScreen extends StatefulWidget {
  var CoachData;

  CoachDetailsScreen({super.key, required this.CoachData});

  @override
  State<CoachDetailsScreen> createState() => _CoachDetailsScreenState();
}

class _CoachDetailsScreenState extends State<CoachDetailsScreen> {

  AtheleteController controller = Get.put(AtheleteController());

  fetchSport(val) {
    var a = [];
    for (int i = 0; i < val.length; i++) {
      a.add(val[i]['sport']);
    }
    String sportsString = a.join(", ");
    return sportsString.toString().capitalizeFirst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          centerTitle: true,
          title: Text(
            "Coach Detail",
            style: montserratMedium.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            /// back ground image
            Positioned.fill(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                AppImages.coachDetailImage,
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

            /// Data Shown here
            Positioned(
                child: SafeArea(
              child: Container(
                width: width(context),
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          padding:
                          const EdgeInsets.all(2),
                          color: Colors.red,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Material(
                                color: Colors.transparent,
                                child: widget.CoachData[
                                'profile_image'] !=
                                    null
                                    ? Image.network(
                                  widget.CoachData[
                                  'profile_image']
                                      .toString(),
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                )
                                    : Image.asset(
                                  'assets/images/demo.png',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width(context) * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(13)),
                        width: width(context),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "${widget.CoachData['name'].toString().capitalizeFirst}",
                              style: montserratBold.copyWith(
                                  color: Colors.white, fontSize: 20),
                            ),
                            richText('Sports:',
                                " ${fetchSport(widget.CoachData['sport_types'])}"),
                            richText('Location:', " Los Angeles"),
                            richText('Gym(s):', " Brick house Boxing Club"),
                            richText('Available for Online Training:', " Yes"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: width(context) * 0.05,
                      ),

                      /// calender
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(13)),
                        width: width(context),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showCustomDateRangePicker(
                                  context,
                                  dismissible: true,
                                  minimumDate: DateTime.now(),
                                  maximumDate: DateTime.now()
                                      .add(const Duration(days: 60)),
                                  endDate: controller.endDate,
                                  startDate: DateTime.now(),
                                  backgroundColor: Colors.white,
                                  primaryColor: AppColors.primaryColor,
                                  onApplyClick: (start, end) {
                                    setState(() {
                                      controller.endDate = end;
                                      controller.startDate = start;
                                    });
                                  },
                                  onCancelClick: () {
                                    setState(() {
                                      controller.endDate = null;
                                      controller.startDate = null;
                                    });
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "Select Date",
                                    controller.endDate == null
                                        ? "Within date range"
                                        : "${DateFormat.yMMMd().format(controller.startDate!)} - ${DateFormat.yMMMd().format(controller.endDate!)}",
                                    style: montserratBold.copyWith(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.primaryColor,
                                  )
                                ],
                              ),
                            ),
                            // CalendarCarousel<Event>(
                            //   todayBorderColor: AppColors.primaryColor,
                            //   onDayPressed: (date, events) {
                            //     setState(() => currentDate2 = date);
                            //     for (var event in events) {
                            //       print(event.title);
                            //     }
                            //   },
                            //   daysHaveCircularBorder: false,
                            //   showOnlyCurrentMonthDate: true,
                            //   inactiveWeekendTextStyle: montserratBold.copyWith(
                            //     color: Colors.white
                            //   ),
                            //   weekdayTextStyle: montserratBold.copyWith(
                            //     color: AppColors.primaryColor,
                            //     fontSize: 14
                            //   ),
                            //
                            //   weekendTextStyle: montserratBold.copyWith(
                            //     color: AppColors.primaryColor,
                            //   ),
                            //   thisMonthDayBorderColor: AppColors.primaryColor,
                            //   weekFormat: false,
                            //   height: height(context) * 0.39,
                            //   selectedDateTime: currentDate2,
                            //   targetDateTime: targetDateTime,
                            //   customGridViewPhysics:
                            //       const NeverScrollableScrollPhysics(),
                            //   markedDateCustomShapeBorder: const CircleBorder(
                            //       side: BorderSide(
                            //           color: AppColors.primaryColor)),
                            //   markedDateCustomTextStyle:
                            //       montserratSemiBold.copyWith(
                            //     fontSize: 18,
                            //     color: Colors.white,
                            //   ),
                            //   showHeader: true,
                            //   todayTextStyle: const TextStyle(
                            //     color: Colors.white,
                            //   ),
                            //   // markedDateShowIcon: true,
                            //   // markedDateIconMaxShown: 2,
                            //   // markedDateIconBuilder: (event) {
                            //   //   return event.icon;
                            //   // },
                            //   // markedDateMoreShowTotal:
                            //   //     true,
                            //   todayButtonColor: Colors.red,
                            //   selectedDayTextStyle: montserratBold.copyWith(
                            //     color: Colors.white,
                            //   ),
                            //   minSelectedDate: currentDate
                            //       .subtract(const Duration(days: 360)),
                            //   maxSelectedDate:
                            //       currentDate.add(const Duration(days: 360)),
                            //   prevDaysTextStyle: montserratBold.copyWith(
                            //     fontSize: 16,
                            //     color: Colors.red,
                            //   ),
                            //   headerTextStyle: montserratBold.copyWith(
                            //       color: AppColors.primaryColor, fontSize: 18),
                            //   iconColor: AppColors.primaryColor,
                            //   daysTextStyle:
                            //       montserratBold.copyWith(color: Colors.white),
                            //   inactiveDaysTextStyle: montserratBold.copyWith(
                            //     color: AppColors.primaryColor,
                            //     fontSize: 16,
                            //   ),
                            //   isScrollable: false,
                            //   onCalendarChanged: (DateTime date) {
                            //     setState(() {
                            //       targetDateTime = date;
                            //       currentMonth =
                            //           DateFormat.yMMM().format(targetDateTime);
                            //     });
                            //   },
                            //   onDayLongPressed: (DateTime date) {
                            //     print('long pressed date $date');
                            //   },
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 50, bottom: 30),
                        child: CustomButton(
                            title: "Next",
                            onTap: () async {
                              Get.to(() => BookATime(
                                    coachId: widget.CoachData['id'],
                                  ));
                            },
                            isTransparent: false,
                            textColor: Colors.white,
                            height: 50),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
