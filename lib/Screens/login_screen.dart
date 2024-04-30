import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:levels_athletes_coaches/BottomBar/buttombar.dart';
import 'package:levels_athletes_coaches/Screens/forget_password_screen.dart';
import 'package:levels_athletes_coaches/Services/auth_services.dart';
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/validator.dart';
import 'package:levels_athletes_coaches/widgets/custom_button.dart';
import 'package:levels_athletes_coaches/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  bool passwordVisible = true;
  final secureStorage = const FlutterSecureStorage();
  AuthService authService = AuthService();
  bool loading = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<String?> readKey(String key) async {
    String? value = await secureStorage.read(key: key);
    return value;
  }

  Future<void> authenticateUser() async {
    setState(() {
      loading = true;
    });
    final username = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      var tokens = await AuthService.getToken(username, password);
      if (tokens != null) {
        // await SharedPref.saveToSharedPref('access_token',tokens['access']);
        await secureStorage.write(key: 'access_token', value: tokens['access']);
        await secureStorage.write(
            key: 'refresh_token', value: tokens['refresh']);
        await secureStorage.write(key: 'type', value: tokens['type']);
        await secureStorage.write(
            key: 'userId', value: (tokens['user_id']).toString());

        //String? myString = await SharedPref.readFromSharedPref('access_token');
        // print(myString);

        String? accessToken = await readKey('access_token');
        Constants.accessToken = accessToken!;
        print(accessToken);
        if (tokens['type'] == 'athlete') {
          Constants.isAthlete = true;
          Constants.athleteModel = await authService.fetchAthleteDetails(
              tokens['access'], tokens['user_id']);

        } else {
          Constants.isAthlete = false;
          Constants.coachModel = await authService.fetchCoachDetails(
              tokens['access'], tokens['user_id']);
        }

        if (Constants.coachModel != null || Constants.athleteModel != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const TabContainer()),
              (Route<dynamic> route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(loginBg), fit: BoxFit.fill),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 25,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    splashRadius: 1,
                                    icon: Icon(!passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword,
                                  ),
                                  controller: passwordController,
                                  textFieldValidator: (value) {
                                    if (!Validators().validatePassword(
                                        passwordController.text.trim())) {
                                      return 'Please enter a valid password';
                                    } else {
                                      return null;
                                    }
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage()));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textColor: Colors.white,
                          title: 'LOGIN',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              authenticateUser();
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
