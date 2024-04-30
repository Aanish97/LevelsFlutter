import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/select_skill_level_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/select_sport_button.dart';

class SelectSport extends StatefulWidget {
  const SelectSport({super.key});

  @override
  State<SelectSport> createState() => _SelectSportState();
}

class _SelectSportState extends State<SelectSport> {
  List<SportsData> sports = [
    SportsData(id: 1, name: 'Boxing', level: ''),
    SportsData(id: 2, name: 'MMA', level: ''),
    SportsData(id: 3, name: 'jui-jitsu', level: ''),
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(background2), fit: BoxFit.cover),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SELECT SPORT(S)',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      SelectSportButton(
                        textColor: Colors.white,
                        title: sports[0].name,
                        onTap: () {
                          toggleSportType(sports[0]);
                        },
                        isTransparent: !selectedSportTypes.contains(sports[0]),
                        height: 70,
                      ),
                      const SizedBox(height: 20),
                      SelectSportButton(
                        textColor: Colors.white,
                        title: sports[1].name,
                        onTap: () {
                          toggleSportType(sports[1]);
                        },
                        isTransparent: !selectedSportTypes.contains(sports[1]),
                        height: 70,
                      ),
                      const SizedBox(height: 20),
                      SelectSportButton(
                        textColor: Colors.white,
                        title: sports[2].name,
                        onTap: () {
                          toggleSportType(sports[2]);
                        },
                        isTransparent: !selectedSportTypes.contains(sports[2]),
                        height: 70,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        textColor: Colors.white,
                        title: 'SUBMIT',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectSkillLevel(
                                        sportData: selectedSportTypes,
                                      )));
                        },
                        isTransparent: false,
                        height: 55,
                      ),
                      const SizedBox(height: 70)
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

class SportsData {
  late int id;
  late String name;
  late String level;

  SportsData({required this.id, required this.name, required this.level});
}
