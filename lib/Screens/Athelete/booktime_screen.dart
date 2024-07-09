import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';

import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';

class BookATime extends StatefulWidget {
  int coachId;

  BookATime({
    super.key,
    required this.coachId,
  });

  @override
  State<BookATime> createState() => _BookATimeState();
}

class _BookATimeState extends State<BookATime> {
  AtheleteController controller = Get.put(AtheleteController());

  getTimeslots() async {
    await controller.fetchCoachesTimeSlots(
      startDate: controller.startDate.toString().split(" ").first ,
      endDate: controller.endDate.toString().split(" ").first,
      id: widget.coachId,
    );
  }

  var selectedIndex=-1;
  var interval=[];
  var selectedIntervalIndex=-1;
  var start_time;
  var end_time;
  @override
  void initState() {
    // TODO: implement initState
    getTimeslots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String isoTimeString = "2024-05-15T08:30:00Z";
    DateTime time = DateTime.parse(isoTimeString);
    String formattedTime = DateFormat.Hm().format(time);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 100,
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
            // Set transparent color
            elevation: 0,
            // Remove elevation
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: height(context) * 0.05),
              child: Image.asset(
                AppImages.appLogo,
                height: 500,
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
              AppImages.loginBg,
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
          Obx(() => SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: controller.timeSlotsLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : SingleChildScrollView(
                    physics:const  NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  Text(
                                    'BOOK A TIME',
                                    style: montserratBold.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${DateFormat.yMMMd().format(controller.startDate!)} - ${DateFormat.yMMMd().format(controller.endDate!)}',
                                    style: montserratSemiBold.copyWith(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.010,
                                  ),
                                  Text(
                                    'Available Time',
                                    style: montserratMedium.copyWith(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.020,
                                  ),
                                  /// time slots render here
                                  SizedBox(
                                    height: height(context) * 0.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                            controller.coachTimeSlots.length,
                                            (index) {
                                          return  Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 8),
                                                child: CustomButton(
                                                    title: " ${controller.coachTimeSlots[index]['day'].toString().capitalizeFirst}",
                                                    // '8:00AM - 9:00AM',
                                                    onTap: () {
                                                      selectedIndex=index;
                                                      setState(() {

                                                      });
                                                      interval.clear();
                                                      interval.addAll(controller.coachTimeSlots[index]['intervals']);
                                                      setState(() {

                                                      });
                                                      print("here is tap data ${interval}");
                                                      // Get.to(() => const ConfirmPayment());
                                                    },
                                                    isTransparent:selectedIndex==index?false: true,
                                                    textColor: Colors.white,
                                                    height: 45),
                                              ),
                                              selectedIndex==index?
                                              SizedBox(
                                                height:height(context)*0.3,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: List.generate(interval.length, (i){
                                                      return Padding(
                                                        padding: const EdgeInsets.only(left: 25.0,right: 25,top: 10),
                                                        child: CustomButton(
                                                            title: "${DateFormat('HH:mm').format(DateTime.parse(interval[i]['start_time']))} - ${DateFormat('HH:mm').format(DateTime.parse(interval[i]['end_time']))}",
                                                            // '8:00AM - 9:00AM',
                                                            onTap: () {


                                                              start_time=interval[i]['start_time'];
                                                              end_time=interval[i]['end_time'];
                                                              selectedIntervalIndex=i;
                                                              setState(() {

                                                              });
                                                              // Get.to(() => const ConfirmPayment());
                                                            },
                                                            isTransparent:selectedIntervalIndex==i?false: true,
                                                            textColor: Colors.white,
                                                            height: 45),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ):const SizedBox()
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.030,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: CustomButton(
                                        title:"Next",
                                         // '8:00AM - 9:00AM',
                                        onTap: () async {
                                          if(selectedIndex==-1){
                                            Get.snackbar("Select Day", "Please select your day",
                                            margin:const  EdgeInsets.all(15),
                                            backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);

                                          } else if(selectedIntervalIndex==-1){
                                            Get.snackbar("Select TimeSlot", "Please select your timeslot",
                                                margin:const  EdgeInsets.all(15),
                                                backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
                                          }else{
                                            await controller.addBooking(
                                              coachId: widget.coachId,
                                              endDate: end_time,
                                              startDate: start_time
                                            );
                                          }
                                          // Get.to(() => const ConfirmPayment());
                                        },
                                        isTransparent:false,
                                        textColor: Colors.white,
                                        height: 50),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              )),
        ],
      ),
    );
  }
}
