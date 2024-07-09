import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/questions_screen.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/select_sport_screen.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/expended_tile.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

import 'package:levels_athletes_coaches/constants/app_sizes.dart';

class SelectSkillLevel extends StatefulWidget {
  final List<SportsData> sportData;

  const SelectSkillLevel({super.key, required this.sportData});

  @override
  State<SelectSkillLevel> createState() => _SelectSkillLevelState();
}

class _SelectSkillLevelState extends State<SelectSkillLevel> {
  final GlobalKey<ExpansionTileCardState> cardBoxing = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMMA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardJitsu = GlobalKey();
  bool isExpandedBoxing = false;
  bool isExpandedMMA = false;
  bool isExpandedJUI = false;

  List<SportsData> selectedSportsData = [];

  @override
  void initState() {
    super.initState();
    // Filter selected sports data based on the previously selected sports
    selectedSportsData = List.from(widget.sportData);
  }

  @override
  Widget build(BuildContext context) {
    for (var element in selectedSportsData) {
      debugPrint(element.id.toString());
    }
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
              AppImages.skillBg,
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
          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(context) * 0.02,
                      ),
                       Text(
                        'SELECT SKILL LEVEL',
                        style: montserratBold.copyWith(
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (var sport in selectedSportsData)
                        Column(
                          children: [
                            const SizedBox(height: 15),
                            ExpendedTile(
                              cardKey: GlobalKey<ExpansionTileCardState>(),
                              title: sport.name,
                              icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                              skillLevel: (String skill) {
                                setState(() {
                                  int sportIdToUpdate = sport.id;
                                  int indexOfSportToUpdate =
                                      selectedSportsData.indexWhere(
                                          (sport) => sport.id == sportIdToUpdate);
                                  if (indexOfSportToUpdate != -1) {
                                    selectedSportsData[indexOfSportToUpdate]
                                        .level = skill;
                                    for (var element in selectedSportsData) {
                                      debugPrint("${element.id} - ${element.name} - ${element.level}");
                                    }
                                  }
                                });
                              },
                              onTap: (expanded) {},
                            ),
                          ],
                        ),
                       SizedBox(
                        height: height(context)*0.03,
                      ),
                      CustomButton(
                        textColor: Colors.white,
                        title: 'SUBMIT',
                        onTap: () {
                          print(selectedSportsData.join(","));
                          Get.to(()=>QuestionsScreen(
                            sportData: selectedSportsData,
                          ));
                        },
                        isTransparent: false,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
