import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/select_skill_level_screen.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/select_sport_button.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_sizes.dart';

class SelectSport extends StatefulWidget {
  const SelectSport({super.key});

  @override
  State<SelectSport> createState() => _SelectSportState();
}

class _SelectSportState extends State<SelectSport> {
  List<SportsData> sports = [
    SportsData(id: 1, name: 'Boxing', level: ''),
    SportsData(id: 2, name: 'MMA', level: ''),
    SportsData(id: 3, name: 'Jiu-Jitsu', level: ''),
  ];
  List<SportsData> selectedSportTypes = [];

  CoachModel coachModel = CoachModel();

  void toggleSportType(SportsData data) {
    setState(() {
      if (selectedSportTypes.contains(data)) {
        selectedSportTypes.remove(data);
      } else {
        selectedSportTypes.add(data);
      }
      for (var element in selectedSportTypes) {
        debugPrint(element.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
            backgroundColor: Colors.transparent, // Set transparent color
            elevation: 0,
            leading:  IconButton(
                onPressed: (){
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,)),
            leadingWidth: 60,// Remove elevation
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: height(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    width: 155,
                    height: 139,
                    fit: BoxFit.cover,
                  ),
                ],
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
              AppImages.sportBg,
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
                color: const Color(0xff000000).withOpacity(0.65),
              )),
          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    const Text(
                      'SELECT SPORT(S)',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    SelectSportButton(
                      textColor: Colors.white,
                      imagePath: AppIcons.boxing,
                      title: sports[0].name,
                      onTap: () {
                        toggleSportType(sports[0]);
                      },
                      isTransparent: !selectedSportTypes.contains(sports[0]),
                      height: 80,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    SelectSportButton(
                      textColor: Colors.white,
                      imagePath: AppIcons.mma,
                      title: sports[1].name,
                      onTap: () {
                        toggleSportType(sports[1]);
                      },
                      isTransparent: !selectedSportTypes.contains(sports[1]),
                      height: 80,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    SelectSportButton(
                      textColor: Colors.white,
                      imagePath: AppIcons.jus,
                      title: sports[2].name,
                      onTap: () {
                        toggleSportType(sports[2]);
                      },
                      isTransparent: !selectedSportTypes.contains(sports[2]),
                      height: 80,
                    ),
                    SizedBox(
                      height: height(context) * 0.04,
                    ),
                    CustomButton(
                      textColor: Colors.white,
                      title: 'SUBMIT',
                      onTap: () {
                        if(selectedSportTypes.isEmpty){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text('Select your sport'),
                            ),
                          );
                        }else{
                          Get.to(() => SelectSkillLevel(
                            sportData: selectedSportTypes,
                          ));
                        }

                      },
                      isTransparent: false,
                      height: 50,
                    ),
                    const SizedBox(height: 70)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SportsData {
  late int id;
  late String name;
  late String level;

  SportsData({required this.id, required this.name, required this.level});
}
