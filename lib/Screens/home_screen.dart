import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/seach_reasult_coach_screen.dart';
import 'package:levels_athletes_coaches/Screens/search_result_athlete_screen.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/helper/utils.dart';
import 'package:levels_athletes_coaches/widgets/home_screen_card.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController(text: '');
  Timer? _debounce;

  String profileImage = (Constants.isAthlete)
      ? Constants.athleteModel?.profileImage ?? ''
      : Constants.coachModel?.profileImage ?? '';

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    _debounce?.cancel();
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
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        color: Colors.red,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: profileImage.isNotEmpty
                                  ? Image.network(
                                      insertAuthPath(profileImage),
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.asset(
                                      'assets/images/demo.png',
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'WELCOME BACK',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                            (Constants.isAthlete)
                                ? Constants.athleteModel!.name.toString()
                                : Constants.coachModel!.name.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          icon: SizedBox(
                            width: 4,
                          ),
                          // icon: Padding(
                          //   padding: const EdgeInsets.only(left: 4),
                          //   child: Container(
                          //     height: 35,
                          //     padding:
                          //         const EdgeInsets.only(left: 10, right: 5),
                          //     decoration: const BoxDecoration(
                          //       color: Colors.red,
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //     ),
                          //     child: const Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Center(
                          //           child: Text(
                          //             'ATHLETE',
                          //             style: TextStyle(
                          //                 color: Colors.white, fontSize: 12),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Icon(
                          //           Icons.arrow_forward_ios_rounded,
                          //           size: 14,
                          //           color: Colors.black,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Search Athlete',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                      validator: (value) =>
                          value == null ? 'Please enter a valid Data' : null,
                      onChanged: _onSearchChanged,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 210,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Wrap(
                          spacing: 7,
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            // ClickableCard(
                            //   title: 'PROGRAMS',
                            //   icon: const Icon(
                            //     Icons.sports_gymnastics,
                            //     size: 40,
                            //     color: Colors.red,
                            //   ),
                            //   color: Colors.white,
                            //   colorLight: Colors.black.withOpacity(0.5),
                            //   onTap: () {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('No data Exist for now'),
                            //       ),
                            //     );
                            //   },
                            // ),
                            Visibility(
                              visible: !Constants.isAthlete,
                              child: ClickableCard(
                                title: 'ATHLETE',
                                icon: const Icon(
                                  Icons.sports_gymnastics,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                color: Colors.white,
                                colorLight: Colors.black.withOpacity(0.5),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchResultAthleteScreen()));
                                },
                              ),
                            ),
                            Visibility(
                              visible: Constants.isAthlete,
                              child: ClickableCard(
                                title: 'COACHES',
                                icon: const Icon(
                                  Icons.sports_gymnastics,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                color: Colors.white,
                                colorLight: Colors.black.withOpacity(0.5),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchResultCoachScreen()));
                                },
                              ),
                            ),
                            // ClickableCard(
                            //   title: 'GYMS',
                            //   icon: const Icon(
                            //     Icons.sports_gymnastics,
                            //     size: 40,
                            //     color: Colors.red,
                            //   ),
                            //   color: Colors.white,
                            //   colorLight: Colors.black.withOpacity(0.5),
                            //   onTap: () {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('No data Exist for now'),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ],
                    ),
                    //Search
                    // const SearchResultCoachScreen()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
