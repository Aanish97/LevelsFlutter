import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';

class CoachSportsProvider extends ChangeNotifier {
  SportType? _sport;

  SportType? get sport => _sport;

  void setCoach(CoachModel coach) {
    _sport = sport;
    notifyListeners();
  }
}
