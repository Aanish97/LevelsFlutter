import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/booktime_screen.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/coach_details.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/home/widgets/booking_widgets.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/home/widgets/coaches_widget.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';

class AthleteHomeScreen extends StatefulWidget {
  const AthleteHomeScreen({super.key});

  @override
  State<AthleteHomeScreen> createState() => _AthleteHomeScreenState();
}

class _AthleteHomeScreenState extends State<AthleteHomeScreen> {
  final TextEditingController location = TextEditingController(text: '');
  AtheleteController controller = Get.put(AtheleteController());
  var selectedGender = "";
  var selectedSport = "";
  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel?.profileImage ?? ''
      : Constants.coachModel?.profileImage ?? '';

  getData() async {
    if(controller.coachList.isEmpty){
      await controller.fetchAllBookings();
      await controller.fetchAllCoaches();
    }

  }



  @override
  void initState() {
    super.initState();
    getData();
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
                    color: const Color(0xff000000).withOpacity(0.6),
                  )),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 5,
                child: Obx(() => SafeArea(
                      child: controller.coachLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: height(context) * 0.9,
                              width: width(context),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height(context) * 0.03,
                                    ),
                                    controller.bookingList.isNotEmpty?BookingWidgets(
                                     bookingData: controller.bookingList,
                                    ):const SizedBox(),
                                    CoachesWidget(
                                      coachData: controller.coachList,
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.06,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
