import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:levels_athletes_coaches/widgets/profile_pic.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.name
          : Constants.coachModel!.name);

  final TextEditingController phoneController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.phoneNumber
          : Constants.coachModel!.phoneNumber);

  final TextEditingController addressController =
      TextEditingController(text: '');

  final TextEditingController emailController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.email
          : Constants.coachModel!.email);

  final TextEditingController birthdayController = TextEditingController(
      text: Constants.isAthlete
          ? Constants.athleteModel!.birthdate
          : Constants.coachModel!.birthdate != null ? DateFormat('yyyy-MM-dd').format(Constants.coachModel!.birthdate!): '');

  final TextEditingController locationController = TextEditingController(
      text: Constants.isAthlete ? Constants.athleteModel!.location : Constants.coachModel!.location);

  final TextEditingController hourlyRateController = TextEditingController(
      text: Constants.isAthlete
          ? ''
          : Constants.coachModel!.hourlyRate.toString());
  final TextEditingController yearsOfTrainingController = TextEditingController(
      text: Constants.isAthlete
          ? ''
          : Constants.coachModel!.yearsOfTraining.toString());
  final TextEditingController yearsOfCoachingController = TextEditingController(
      text: Constants.isAthlete
          ? ''
          : Constants.coachModel!.yearsOfCoaching.toString());

  final TextEditingController availabilityController =
      TextEditingController(text: '');

  final TextEditingController bankDetailController =
      TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        debugPrint('Selected Date: $formattedDate');
        birthdayController.text = formattedDate;
      });
    }
  }

  String imageFile = "";

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        print(file.path);
        imageFile = file.path;
        setState(() {});
      }
    }catch(error){
      debugPrint(error.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Something wrong or this format not allowed, please select other photo'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            SafeArea(
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            Expanded(
              child: Container(
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Center(
                              child: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 15,
                          ),
                          ProfilePicWidget(
                            imagePath: imageFile,
                            onClicked: _pickImage,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputField(
                                    hintText: "Name",
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    suffixIcon: const SizedBox(),
                                    controller: nameController,
                                    textFieldValidator: (value) {
                                      if (value == null) {
                                        return 'Please enter a valid Name';
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputField(
                                    hintText: 'Phone',
                                    obscureText: false,
                                    keyboardType: TextInputType.phone,
                                    suffixIcon: const SizedBox(),
                                    controller: phoneController,
                                    textFieldValidator: (value) {
                                      if (!Validators().validateNumber(
                                          phoneController.text.trim())) {
                                        return 'Please enter a valid phone';
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputField(
                                    hintText: 'Email',
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    suffixIcon: const SizedBox(),
                                    controller: emailController,
                                    textFieldValidator: (value) {
                                      if (!Validators().validateEmail(
                                          emailController.text.trim())) {
                                        return 'Please enter a valid email';
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputField(
                                    hintText: 'Birth Date',
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        await selectDate(context);
                                      },
                                      child: const Icon(
                                        Icons.calendar_month,
                                        color: Colors.red,
                                      ),
                                    ),
                                    controller: birthdayController,
                                    textFieldValidator: (value) {
                                      if (value == null) {
                                        return 'Please enter a valid date';
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: !Constants.isAthlete,
                                  child: InputField(
                                      hintText: 'Location',
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      suffixIcon: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      controller: locationController,
                                      textFieldValidator: (value) {
                                        if (value == null) {
                                          return 'Please enter a valid location';
                                        } else {
                                          return null;
                                        }
                                      }),
                                ),
                                Visibility(
                                  visible: !Constants.isAthlete,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputField(
                                          hintText: 'Hourly rate',
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          suffixIcon: const Icon(
                                            Icons.attach_money,
                                            color: Colors.red,
                                          ),
                                          controller: hourlyRateController,
                                          textFieldValidator: (value) {
                                            if (value == null) {
                                              return 'Please enter a valid hourly rate';
                                            } else {
                                              return null;
                                            }
                                          }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputField(
                                          hintText: 'Availability',
                                          keyboardType: TextInputType.text,
                                          obscureText: false,
                                          suffixIcon: const Icon(
                                            Icons.calendar_month,
                                            color: Colors.red,
                                          ),
                                          controller: availabilityController,
                                          textFieldValidator: (value) {
                                            if (value == null) {
                                              return 'Please enter a valid availability hours';
                                            } else {
                                              return null;
                                            }
                                          }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputField(
                                          hintText: 'Bank Details',
                                          keyboardType: TextInputType.text,
                                          obscureText: false,
                                          suffixIcon: const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          controller: bankDetailController,
                                          textFieldValidator: (value) {
                                            if (value == null) {
                                              return 'Please enter a valid bank details';
                                            } else {
                                              return null;
                                            }
                                          }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputField(
                                        hintText: 'Years of training',
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        controller: yearsOfTrainingController,
                                        textFieldValidator: (value) {
                                          if (value == null) {
                                            return 'Please enter a valid years of training';
                                          } else {
                                            return null;
                                          }
                                        }, suffixIcon: const SizedBox(),),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputField(
                                        hintText: 'Years of coaching',
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        controller: yearsOfCoachingController,
                                        textFieldValidator: (value) {
                                          if (value == null) {
                                            return 'Please enter a valid Years of coaching';
                                          } else {
                                            return null;
                                          }
                                        }, suffixIcon: const SizedBox(),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            textColor: Colors.white,
                            title: 'SAVE CHANGES',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                if (Constants.isAthlete) {
                                  AthleteModel updateData = AthleteModel(
                                    id: Constants.athleteModel!.id,
                                    name:
                                        nameController.text.trim().isNotEmpty
                                            ? nameController.text.trim()
                                            : Constants.athleteModel!.name,
                                    email:
                                        emailController.text.trim().isNotEmpty
                                            ? emailController.text.trim()
                                            : Constants.athleteModel!.email,
                                    username:
                                    emailController.text.trim().isNotEmpty
                                        ? emailController.text.trim()
                                        : Constants.athleteModel!.email,
                                    phoneNumber: phoneController.text.trim(),
                                    location: locationController.text.trim(),

                                    //just values
                                    firstName: '',
                                    lastName: '',

                                    isSuperuser: false,
                                    isStaff: false,
                                    isActive: true,
                                    dateJoined: DateTime.timestamp(),
                                    groups: [],
                                    userPermissions: [],
                                    bio: '',
                                    lastLogin: DateTime.timestamp(),
                                    password: '',
                                    birthdate: '',
                                    profileImage: '',
                                  );
                                  AuthService authRepo = AuthService();
                                  await authRepo.updateAthleteDetails(
                                      updateData, imageFile, Constants.accessToken);
                                  Constants.athleteModel =
                                      await authRepo.fetchAthleteDetails(
                                          Constants.accessToken,
                                          Constants.athleteModel!.id);
                                  setState(() {
                                    loading = false;
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Profile updated successfully.'),
                                      ),
                                    );
                                  }
                                } else {
                                  CoachModel updateData = CoachModel(
                                    id: Constants.coachModel!.id,
                                    name:
                                        nameController.text.trim().isNotEmpty
                                            ? nameController.text.trim()
                                            : Constants.coachModel!.name,
                                    email:
                                        emailController.text.trim().isNotEmpty
                                            ? emailController.text.trim()
                                            : Constants.coachModel!.email,
                                    username:
                                    emailController.text.trim().isNotEmpty
                                        ? emailController.text.trim()
                                        : Constants.coachModel!.email,
                                    phoneNumber:
                                        phoneController.text.trim().isNotEmpty
                                            ? phoneController.text.trim()
                                            : Constants.coachModel!.phoneNumber,
                                    location: locationController.text.trim(),
                                    hourlyRate:
                                        int.parse(hourlyRateController.text),
                                    yearsOfCoaching: int.parse(yearsOfCoachingController.text.trim()),
                                    yearsOfTraining: int.parse(yearsOfTrainingController.text.trim()),
                                    // birthdate: DateTime.timestamp(),
                                  );
                                  AuthService authRepo = AuthService();
                                  await authRepo.updateCoachDetails(updateData,
                                      imageFile, Constants.accessToken);
                                  Constants.coachModel =
                                      await authRepo.fetchCoachDetails(
                                          Constants.accessToken,
                                          Constants.coachModel!.id);
                                  setState(() {
                                    loading = false;
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Profile updated successfully.'),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                (ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('please fill all the details.'),
                                  ),
                                ));
                              }
                            },
                            isTransparent: false,
                            height: 55,
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : null,
                          )
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
