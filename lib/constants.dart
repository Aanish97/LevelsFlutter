import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';

const String serverUrl = 'http://24.199.105.52/v1';

// const String backgroundImage = 'assets/images/bg.jpg';
// const String background1 = 'assets/images/BG-01.jpg';
// const String background2 = 'assets/images/BG-02.jpg';
// const String background3 = 'assets/images/BG-03.jpg';
// const String background4 = 'assets/images/BG-04.jpg';
// const String background5 = 'assets/images/BG-05.jpg';
// const String loginBg = 'assets/images/login-bg.png';

class Constants {
  static AthleteModel? athleteModel;
  static CoachModel? coachModel;
  static late bool isAthlete;
  static late String accessToken;
}
