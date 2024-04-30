import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';

class CoachProvider extends ChangeNotifier {
  CoachModel? _coach;

  CoachModel? get coach => _coach;

  void setCoach(CoachModel coach) {
    _coach = coach;
    notifyListeners();
  }
}
