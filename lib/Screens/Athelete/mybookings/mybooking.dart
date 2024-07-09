import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:levels_athletes_coaches/constants/app_images.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  AtheleteController controller = Get.put(AtheleteController());
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(controller.bookingList.isEmpty){
      controller.coachLoading.value = true;
      controller.fetchAllBookings();
      controller.coachLoading.value = false;
    }else{
      controller.fetchAllBookings();
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
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
                color: const Color(0xff000000).withOpacity(0.5),
              )),
          SafeArea(
            child: Obx(()=>SizedBox(
              width: width(context),
              height: height(context),
              child: controller.coachLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : controller.bookingList.isEmpty
                      ? Center(
                          child: Text(
                            "No Booking Found",
                            style: montserratMedium.copyWith(
                                color: AppColors.whiteColor, fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.bookingList.length,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: height(context) * 0.1,
                              top: height(context) * 0.015),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54,
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.5)),
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 15, top: 15),
                                  child: Row(
                                    children: [
                                      /// profile images
                                      ClipOval(
                                        child: Container(
                                          padding:
                                          const EdgeInsets
                                              .all(2),
                                          color: Colors.red,
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.white,
                                              child: Material(
                                                color: Colors
                                                    .transparent,
                                                child: controller.bookingList[index]
                                                ['coach']
                                                ['profile_image'] !=
                                                    null
                                                    ? Image
                                                    .network(
                                                  controller
                                                      .bookingList[
                                                  index]
                                                  [
                                                  'coach']
                                                  [
                                                  'profile_image']
                                                      .toString(),
                                                  fit: BoxFit
                                                      .cover,
                                                  width: 55,
                                                  height:
                                                  55,
                                                )
                                                    : Image.asset(
                                                  'assets/images/demo.png',
                                                  fit: BoxFit
                                                      .cover,
                                                  width: 60,
                                                  height:
                                                  60,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(context) * 0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.bookingList[index]['coach']['name'].toString().capitalizeFirst}",
                                            style: montserratMedium.copyWith(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          richText(
                                            'Date:',
                                            ' ${DateFormat.yMMMd().format(DateTime.parse(controller.bookingList[index]['start_time']))} - ${DateFormat.yMMMd().format(DateTime.parse(controller.bookingList[index]['end_time']))}',
                                          ),
                                          richText(
                                            'Day:',
                                            ' ${DateFormat('EEEE').format(DateTime.parse(controller.bookingList[index]['start_time']))}',
                                          ),
                                          richText(
                                            'Time:',
                                            ' ${DateFormat('HH:mm a').format(DateTime.parse(controller.bookingList[index]['start_time']))} - ${DateFormat('HH:mm a').format(DateTime.parse(controller.bookingList[index]['end_time']))}',
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
            )),
          )
        ],
      ),
    );
  }
}
