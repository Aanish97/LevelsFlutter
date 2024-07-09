import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/coach_details.dart';
import 'package:levels_athletes_coaches/Screens/Athelete/home/widgets/view_all_coaches.dart';

import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/richText.dart';

class CoachesWidget extends StatefulWidget {
  List coachData;

  CoachesWidget({super.key, required this.coachData});

  @override
  State<CoachesWidget> createState() => _CoachesWidgetState();
}

class _CoachesWidgetState extends State<CoachesWidget> {
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
    return widget.coachData.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height(context)*0.6,
              child: Center(
                child: Text("No Coach Found",style: montserratMedium.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),),
              ),
            )
          ],
        ):
    Column(
      children: [
        /// coaches
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Available Coaches",
              style: montserratBold.copyWith(color: Colors.white, fontSize: 16),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>const ViewAllCoaches());
              },
              child: Text(
                "View all",
                style: montserratMedium.copyWith(
                    color: AppColors.primaryColor, fontSize: 14),
              ),
            )
          ],
        ),
        SizedBox(
          height: height(context) * 0.015,
        ),
        /// coach list view
        ListView.builder(
          itemCount: widget.coachData.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.to(() => CoachDetailsScreen(
                      CoachData: widget.coachData[index],
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black54,
                      border: Border.all(
                          color: AppColors.primaryColor, width: 0.5)),
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
                                    child: widget.coachData[index]['profile_image'] !=
                                        null
                                        ? Image.network(
                                      widget.coachData[index]['profile_image']
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.coachData[index]['name'].toString().capitalizeFirst}",
                                style: montserratMedium.copyWith(
                                    fontSize: 16, color: Colors.white),
                              ),
                              richText('Years of Coaching:',
                                  " ${widget.coachData[index]['years_of_coaching']}"),
                              richText('Sports:',
                                  " ${fetchSport(widget.coachData[index]['sport_types'])}"),
                              widget.coachData[index]['bio']
                                          .toString()
                                          .isEmpty ||
                                      widget.coachData[index]['bio']
                                              .toString() ==
                                          "null"
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: width(context) * 0.57,
                                      child: richText('Bio:',
                                          " ${widget.coachData[index]['bio']}"),
                                    ),
                            ],
                          )
                        ],
                      ),
                       SizedBox(
                        height: height(context)*0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15),
                        child: CustomButton(
                            title: "Book Now",
                            onTap: () {
                              Get.to(() => CoachDetailsScreen(
                                    CoachData: widget.coachData[index],
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
    );
  }
}
