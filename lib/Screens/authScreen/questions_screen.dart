import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/login_screen.dart';
import 'package:levels_athletes_coaches/Screens/authScreen/select_sport_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/coach_provider.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:levels_athletes_coaches/constants/app_images.dart';

class QuestionsScreen extends StatefulWidget {
  final List<SportsData> sportData;

  const QuestionsScreen({super.key, required this.sportData});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final TextEditingController trainedTimeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController coachedTimeController = TextEditingController();
  final TextEditingController proFighterTimeController =
      TextEditingController();
  final TextEditingController question1Controller = TextEditingController();
  final TextEditingController question2Controller = TextEditingController();
  int selectedValue = 1;
  bool isFighter = false;
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
            backgroundColor: Colors.transparent,
            // Set transparent color
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                )),
            leadingWidth: 60,
            // Remove elevation
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key:formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(
                            'Answer the questions below?',
                            style: montserratBold.copyWith(fontSize: kFont18),
                          )),
                          SizedBox(
                            height: height(context) * 0.015,
                          ),
                          Center(
                              child: Text(
                            'How long have you trained?',
                            style: montserratMedium.copyWith(fontSize: kFont14),
                          )),
                          SizedBox(
                            height: height(context) * 0.015,
                          ),
                          CustomTextField(
                              hintText: 'years',
                              keyboardType: TextInputType.number,
                              isObscure: false,
                              suffixIcon: const SizedBox(),
                              controller: trainedTimeController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Required Field';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text('How long have you coached?',
                                  style: montserratMedium.copyWith(
                                      fontSize: kFont14))),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                              hintText: 'years',
                              keyboardType: TextInputType.number,
                              isObscure: false,
                              suffixIcon: const SizedBox(),
                              controller: coachedTimeController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Required field';
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(
                            height: height(context) * 0.015,
                          ),
                          Center(
                              child: Text('Were you a professional fighter?',
                                  style: montserratMedium.copyWith(
                                      fontSize: kFont14))),
                          SizedBox(
                            height: height(context) * 0.015,
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
                          SizedBox(
                            height: height(context) * 0.015,
                          ),
                          CustomTextField(
                              controller: bioController, hintText: "Enter your bio",
                            maxLines: 4,
                            minLines: 2,
                            validator: (val){
                              if (val!.trim().isEmpty) {
                                return 'required field';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: height(context) * 0.05,
                          ),
                          CustomButton(
                            textColor: Colors.white,
                            title: 'SUBMIT',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                CoachModel coachData = coachProvider.coach ?? CoachModel();
                                coachData.sportTypes = widget.sportData.cast<SportType>();
                                coachData.yearsOfTraining = int.parse(trainedTimeController.text.trim());
                                coachData.yearsOfCoaching = int.parse(coachedTimeController.text.trim());
                                coachData.bio = bioController.text.trim();
                                coachData.professionalFighter = isFighter;
                                coachProvider.setCoach(coachData);
                                bool? isSignUp = await authService.createCoach(coachData,context);
                                if (isSignUp!) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.offAll(() => const LoginScreen());
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text('Something went wrong, try later!'),
                                    ),
                                  );
                                }
                              }

                            },
                            isTransparent: false,
                            height: 50,
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
          ),
        ],
      ),
    );
  }
}
