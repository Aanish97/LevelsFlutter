import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/show_profile.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/widgets/search_result_card.dart';

class SearchResultAthleteScreen extends StatefulWidget {
  const SearchResultAthleteScreen({super.key});

  @override
  State<SearchResultAthleteScreen> createState() =>
      _SearchResultAthleteScreenState();
}

class _SearchResultAthleteScreenState extends State<SearchResultAthleteScreen> {
  late List<AthleteModel> coaches = [];
  final StreamController<List<AthleteModel>> athleteController =
      StreamController<List<AthleteModel>>();

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  fetchData() async {
    coaches = await AuthService.fetchAllAthletes(Constants.accessToken);
    athleteController.add(coaches);
  }

  @override
  void dispose() {
    athleteController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: StreamBuilder<List<AthleteModel>>(
            stream: athleteController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back_ios_new_rounded, size: 30,color: Colors.white,),
                              )),
                          const SizedBox(width: 10,),
                          Text(
                            '${snapshot.data!.length} Athlete list',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        itemCount: snapshot.data!.length,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return searchResultCard(
                            snapshot.data![index].name,
                            'Boxing',
                            '',
                            'assets/images/demo.png',
                            snapshot.data![index].bio ?? "",
                            context,
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowProfileScreen(
                                            isCoach:
                                                false,
                                            athleteModel:
                                                snapshot.data![index],
                                          )));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SearchResult {
  late String name;
  late String sportName;
  late String location;
  late String profilePic;
  late String description;

  SearchResult(this.name, this.sportName, this.location, this.profilePic,
      this.description);
}
