import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/login_screen.dart';
import 'package:levels_athletes_coaches/Screens/select_sport_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/coach_provider.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  final TextEditingController phoneNoController =
      TextEditingController(text: '');
  String professionType = 'ATHLETE';
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool loading = false;

  void setProfessionType(String type) {
    setState(() {
      professionType = type;
      debugPrint(professionType);
    });
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var coachProvider = Provider.of<CoachProvider>(context);
    return Container(
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios_new_rounded, size: 30,color: Colors.white,),
                      )),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(width: 30,)
                ],
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(child: Text('Are you an')),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  textColor: (professionType == 'ATHLETE')
                                      ? Colors.white
                                      : Colors.black,
                                  title: 'ATHLETE',
                                  onTap: () {
                                    setProfessionType('ATHLETE');
                                  },
                                  isTransparent: (professionType == 'ATHLETE')
                                      ? false
                                      : true,
                                  height: 45,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  textColor: (professionType == 'COACH')
                                      ? Colors.white
                                      : Colors.black,
                                  title: 'COACH',
                                  onTap: () {
                                    setProfessionType('COACH');
                                  },
                                  isTransparent: (professionType == 'COACH')
                                      ? false
                                      : true,
                                  height: 45,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                            child: Text('Fill out the details below:')),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputField(
                                  hintText: 'Name',
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: const SizedBox(),
                                  controller: nameController,
                                  textFieldValidator: (value) {
                                    if (!Validators().validateName(
                                        nameController.text.trim())) {
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
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                  suffixIcon: const SizedBox(),
                                  controller: phoneNoController,
                                  textFieldValidator: (value) {
                                    if (!Validators().validateNumber(
                                        phoneNoController.text.trim())) {
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
                                  hintText: 'Password',
                                  obscureText: passwordVisible,
                                  keyboardType: TextInputType.text,
                                  controller: passwordController,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    splashRadius: 1,
                                    icon: Icon(!passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword,
                                  ),
                                  textFieldValidator: (value) {
                                    if (!Validators().validatePassword(
                                        passwordController.text.trim())) {
                                      return 'Please enter a valid password';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              InputField(
                                  hintText: 'Confirm Password',
                                  obscureText: confirmPasswordVisible,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    splashRadius: 1,
                                    icon: Icon(!confirmPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: toggleConfirmPassword,
                                  ),
                                  controller: confirmPasswordController,
                                  textFieldValidator: (value) {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return 'Password is not match';
                                    } else {
                                      return null;
                                    }
                                  }),
                            ],
                          ),
                        ),
                        SafeArea(
                          child: CustomButton(
                            textColor: Colors.white,
                            title: 'SUBMIT',
                            onTap: () async {
                              if (professionType == 'ATHLETE') {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  AthleteModel userData = AthleteModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    username: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phoneNumber: phoneNoController.text.trim(),
                                    bio: '',
                                    birthdate: '',
                                    dateJoined: DateTime.timestamp(),
                                    firstName: '',
                                    lastName: '',
                                    location: '',
                                    isSuperuser: false,
                                    isStaff: false,
                                    isActive: true,
                                    groups: [],
                                    userPermissions: [],
                                    id: 0,
                                    profileImage: '',
                                  );
                                  bool isSignUp = await AuthService.createAthlete(userData);
                                  if(isSignUp) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginScreen()));
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Something went wrong, try later!'),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  CoachModel coach = CoachModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phoneNumber: phoneNoController.text.trim(),
                                    username: emailController.text.trim(),
                                    firstName: '',
                                    lastName: '',
                                    location: '',
                                    isSuperuser: false,
                                    isStaff: false,
                                    isActive: true,
                                    dateJoined: DateTime.timestamp(),
                                    groups: [],
                                    userPermissions: [],
                                    answers: [],
                                    hourlyRate: 0,
                                    bio: '',
                                    birthdate: DateTime.timestamp(),
                                    lastLogin: DateTime.timestamp(),
                                    sportTypes: [],
                                    yearsOfCoaching: 0,
                                    yearsOfTraining: 0,
                                    professionalFighter: false,
                                  );
                                  coachProvider.setCoach(coach);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SelectSport()));
                                }
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
                        ),
                      ],
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
