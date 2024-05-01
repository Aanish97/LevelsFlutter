import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/login_screen.dart';
import 'package:levels_athletes_coaches/Screens/select_sport_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/coach_provider.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class QuestionsScreen extends StatefulWidget {
  final List<SportsData> sportData;

  const QuestionsScreen({super.key, required this.sportData});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final TextEditingController trainedTimeController =
      TextEditingController(text: '0');
  final TextEditingController coachedTimeController =
      TextEditingController(text: '0');
  final TextEditingController proFighterTimeController =
      TextEditingController(text: '');
  final TextEditingController question1Controller =
      TextEditingController(text: '');
  final TextEditingController question2Controller =
      TextEditingController(text: '');
  int selectedValue = 1;
  bool isFighter = false;
  bool loading = false;

  AuthService authService = AuthService();

  List<SportType> convertToSportTypeList(List<SportsData> sportsDataList) {
    return sportsDataList.map((sportsData) {
      return SportType(
        id: sportsData.id,
        sport: sportsData.name,
        level: sportsData.level,
      );
    }).toList();
  }

  void isProFighter(int value) {
    value == 1 ? isFighter = true : isFighter = false;
    print('Fighter $isFighter');
  }

  @override
  Widget build(BuildContext context) {
    var coachProvider = Provider.of<CoachProvider>(context);
    for (var element in widget.sportData) {
      print("${element.id} - ${element.name} - ${element.level}");
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.background4), fit: BoxFit.cover),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      )),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Center(
                              child: Text(
                            'Answer the questions below?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 15,
                          ),
                          const Center(
                              child: Text('How long have you trained?')),
                          const SizedBox(
                            height: 5,
                          ),
                          InputField(
                              hintText: 'years',
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              suffixIcon: const SizedBox(),
                              controller: trainedTimeController,
                              textFieldValidator: (value) {
                                if (value == null) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                              child: Text('How long have you coached?')),
                          const SizedBox(
                            height: 5,
                          ),
                          InputField(
                              hintText: 'years',
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              suffixIcon: const SizedBox(),
                              controller: coachedTimeController,
                              textFieldValidator: (value) {
                                if (value == null) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                              child: Text('Were you a professional fighter?')),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: RadioListTile(
                                    splashRadius: 10.0,
                                    activeColor: Colors.red,
                                    title: const Text('Yes'),
                                    value: 1,
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                        isProFighter(value);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: RadioListTile(
                                    activeColor: Colors.red,
                                    title: const Text('No'),
                                    value: 2,
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                        isProFighter(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            textColor: Colors.white,
                            title: 'SUBMIT',
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                              CoachModel coachData =
                                  coachProvider.coach ?? CoachModel();
                              coachData.sportTypes =
                                  widget.sportData.cast<SportType>();
                              coachData.yearsOfTraining =
                                  int.parse(trainedTimeController.text.trim());
                              coachData.yearsOfCoaching =
                                  int.parse(coachedTimeController.text.trim());
                              coachData.professionalFighter = isFighter;
                              coachProvider.setCoach(coachData);
                              // var coachJson = coachData.toJson();
                              // print(coachJson);
                              // print('Name: ${coachData.name}');
                              // print('Sport types :');
                              // coachData.sportTypes?.forEach((element) {
                              //   print(element.sport);
                              // });
                              // print('Email: ${coachData.email}');
                              // print('Phone: ${coachData.phoneNumber}');
                              // print('Training: ${coachData.yearsOfTraining}');
                              // print('Coaching: ${coachData.yearsOfCoaching}');
                              // print('Is Fighter: ${coachData.professionalFighter}');
                              bool isSignUp =
                                  await authService.createCoach(coachData);
                              if (isSignUp) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (Route<dynamic> route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Something went wrong, try later!'),
                                  ),
                                );
                              }
                            },
                            isTransparent: false,
                            height: 55,
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
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
