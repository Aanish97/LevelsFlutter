import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/Coaches/seach_reasult_coach_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController locationController =
      TextEditingController(text: '');
  final TextEditingController sportController = TextEditingController(text: '');
  final TextEditingController yearsOfCoachingController =
      TextEditingController(text: '');
  final TextEditingController genderController =
      TextEditingController(text: '');

  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel!.profileImage!
      : Constants.coachModel!.profileImage!;

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
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 210,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      height: 55,
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: SvgPicture.asset(
                                  'assets/SVGs/coach.svg',
                                ),
                              ),
                            ),*/
                            Text(
                              'COACHES',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Location',
                      keyboardType: TextInputType.text,
                      onTap: (){

                      },
                      suffixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      controller: locationController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Sport',
                      keyboardType: TextInputType.text,
                      onTap: (){

                      },
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.red,
                      ),
                      controller: sportController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Years of coaching',
                      keyboardType: TextInputType.number,
                      onTap: (){

                      },
                      suffixIcon: const SizedBox(),
                      controller: yearsOfCoachingController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      hintText: 'Gender',
                      keyboardType: TextInputType.text,
                      onTap: (){

                      },
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.red,
                      ),
                      controller: genderController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                        title: 'SEARCH',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchResultCoachScreen()));
                        },
                        isTransparent: false,
                        textColor: Colors.white,
                        height: 55)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
