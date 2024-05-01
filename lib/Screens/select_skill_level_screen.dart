import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/questions_screen.dart';
import 'package:levels_athletes_coaches/Screens/select_sport_screen.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/expended_tile.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(AppImages.background2), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 30,color: Colors.white,),
                      )),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(width: 30,)
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'SELECT SKILL LEVEL',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
                              icon: const Icon(Icons.arrow_drop_down),
                              skillLevel: (String skill) {
                                setState(() {
                                  int sportIdToUpdate = sport.id;
                                  int indexOfSportToUpdate =
                                      selectedSportsData.indexWhere((sport) =>
                                          sport.id == sportIdToUpdate);
                                  if (indexOfSportToUpdate != -1) {
                                    selectedSportsData[indexOfSportToUpdate]
                                        .level = skill;
                                    for (var element in selectedSportsData) {
                                      debugPrint(
                                          "${element.id} - ${element.name} - ${element.level}");
                                    }
                                  }
                                });
                              },
                              onTap: (expanded) {},
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: CustomButton(
                          textColor: Colors.white,
                          title: 'SUBMIT',
                          onTap: () {
                            print(selectedSportsData.join(","));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuestionsScreen(
                                          sportData: selectedSportsData,
                                        )));
                          },
                          isTransparent: false,
                          height: 55,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
