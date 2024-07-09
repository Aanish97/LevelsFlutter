import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Controllers/coach_controller/coach_controller.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profileImage = Constants.coachModel?.profileImage ?? '';
  CoachController controller = Get.put(CoachController());

  getData() async {
    if(controller.bookingList.isEmpty){
      controller.coachLoading.value = true;
      await controller.fetchAllBookings();
    }else{
      controller.fetchAllBookings();
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() => SizedBox(
                height: height(context),
                child: Stack(
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
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: height(context) * 0.79,
                            width: width(context),
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
                                              color: AppColors.whiteColor,
                                              fontSize: 20),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            controller.bookingList.length,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: height(context) * 0.1,
                                            top: height(context) * 0.015),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                                            const EdgeInsets
                                                                .all(2),
                                                        color: Colors.red,
                                                        child: ClipOval(
                                                          child: Container(
                                                            color: Colors.white,
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: profileImage
                                                                      .isNotEmpty
                                                                  ? Image
                                                                      .network(
                                                                      controller
                                                                          .bookingList[
                                                                              index]
                                                                              [
                                                                              'athlete']
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
                                                      width:
                                                          width(context) * 0.02,
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
                                                          "${controller.bookingList[index]['athlete']['name'].toString().capitalizeFirst}",
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
