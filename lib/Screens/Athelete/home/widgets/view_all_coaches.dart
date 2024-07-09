import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Controllers/athelete_controllers/athelete_controller.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/coach_details.dart';
class ViewAllCoaches extends StatefulWidget {
  const ViewAllCoaches({super.key});

  @override
  State<ViewAllCoaches> createState() => _ViewAllCoachesState();
}

class _ViewAllCoachesState extends State<ViewAllCoaches> {
  AtheleteController controller = Get.put(AtheleteController());

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  fetchSport(val) {
    var a = [];
    for (int i = 0; i < val.length; i++) {
      a.add(val[i]['sport']);
    }
    String sportsString = a.join(", ");
    return sportsString.toString().capitalizeFirst;
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 80,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "All Coaches",
            style: montserratMedium.copyWith(color: Colors.white),
          ),
        ),
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
          Obx(()=>SafeArea(
            child: Column(
              children: [
                /// coach list view
                controller.coachLoading.value?
                SizedBox(
                  height: height(context)*0.7,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ):
                ListView.builder(
                  itemCount: controller.coachList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => CoachDetailsScreen(
                          CoachData: controller.coachList[index],
                        ));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black54,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 0.5)),
                          margin: EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                            child: controller.searchList[
                                            index][
                                            'profile_image'] !=
                                                null
                                                ? Image.network(
                                              controller
                                                  .searchList[
                                              index][
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
                                    width: width(context) * 0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.coachList[index]['name'].toString().capitalizeFirst}",
                                        style: montserratMedium.copyWith(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      richText('Years of Coaching:',
                                          " ${controller.coachList[index]['years_of_coaching']}"),
                                      richText('Sports:',
                                          " ${fetchSport(controller.coachList[index]['sport_types'])}"),
                                      controller.coachList[index]['bio']
                                          .toString()
                                          .isEmpty ||
                                          controller.coachList[index]['bio']
                                              .toString() ==
                                              "null"
                                          ? const SizedBox()
                                          : SizedBox(
                                        width: width(context) * 0.57,
                                        child: richText('Bio:',
                                            " ${controller.coachList[index]['bio']}"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 15.0, left: 15),
                                child: CustomButton(
                                    title: "Book Now",
                                    onTap: () {
                                      Get.to(() => CoachDetailsScreen(
                                        CoachData:controller.coachList[index],
                                      ));
                                    },
                                    isTransparent: true,
                                    fontSize: 18,
                                    textColor: AppColors.whiteColor,
                                    height: 45),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
