import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';
class BookingWidgets extends StatefulWidget {
  var bookingData;
   BookingWidgets({super.key,this.bookingData});

  @override
  State<BookingWidgets> createState() => _BookingWidgetsState();
}

class _BookingWidgetsState extends State<BookingWidgets> {
  AtheleteController controller = Get.put(AtheleteController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// my Booking
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Bookings",
              style: montserratBold.copyWith(
                  color: Colors.white,
                  fontSize: 16),
            ),
            InkWell(
              onTap: (){
                controller.motionTabBarController!.index=2;
                setState(() {

                });
              },
              child: Text(
                "View all",
                style: montserratMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 14),
              ),
            )
          ],
        ),
        SizedBox(
          height: height(context) * 0.015,
        ),
        ListView.builder(
          itemCount:
          widget.bookingData.length > 3
              ? 3
              : widget.bookingData.length,
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemBuilder:
              (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Get.to(() => CoachDetailsScreen(
                //   CoachData: controller
                //       .coachList[index],
                // ));
              },
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(15),
                      color: Colors.black54,
                      border: Border.all(
                          color: AppColors
                              .primaryColor,
                          width: 0.5)),
                  padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 15,
                      top: 15),
                  child: Row(
                    children: [
                      /// profile images
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
                                child: widget.bookingData[
                                index]
                                ['coach'][
                                'profile_image'] !=
                                    null
                                    ? Image.network(
                                  widget.bookingData[
                                  index]
                                  ['coach'][
                                  'profile_image']
                                      .toString(),
                                  fit: BoxFit.cover,
                                  width: 55,
                                  height: 55,
                                )
                                    : Image.asset(
                                  'assets/images/demo.png',
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:
                        width(context) * 0.03,
                      ),
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceEvenly,
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            "${widget.bookingData[index]['coach']['name'].toString().capitalizeFirst}",
                            style: montserratMedium
                                .copyWith(
                                fontSize: 18,
                                color: Colors
                                    .white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          richText(
                            'Date:',
                            ' ${DateFormat.yMMMd().format(DateTime.parse(widget.bookingData[index]['start_time']))} - ${DateFormat.yMMMd().format(DateTime.parse(widget.bookingData[index]['end_time']))}',
                          ),
                          richText(
                            'Day:',
                            ' ${DateFormat('EEEE').format(DateTime.parse(widget.bookingData[index]['start_time']))}',
                          ),
                          richText(
                            'Time:',
                            ' ${DateFormat('HH:mm a').format(DateTime.parse(widget.bookingData[index]['start_time']))} - ${DateFormat('HH:mm a').format(DateTime.parse(widget.bookingData[index]['end_time']))}',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
        SizedBox(
          height: height(context) * 0.02,
        ),
      ],
    );
  }
}
