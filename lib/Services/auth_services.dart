import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:levels_athletes_coaches/constants.dart';
import 'package:levels_athletes_coaches/models/coach_model.dart';
import 'package:levels_athletes_coaches/models/user_model.dart';

class AuthService {
  static Future<Map<String, dynamic>?> getToken(
      String username, String password) async {
    final url = Uri.parse('$serverUrl/auth/token/');
    final Map<String, String> requestBody = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        Map<String, dynamic> data = json.decode(response.body);
        print('AuthService.getToken');
        print(data.toString());
        return data;
      } else {
        return null;
      }
    } else {
      print('Authentication failed');
    }
    return null;
  }

  static Future<bool> createAthlete(AthleteModel user,BuildContext context) async {
    const String apiUrl = '$serverUrl/auth/create-athlete/';
    final Map<String, dynamic> userMap = user.toJsonForCreateAthlete();
    debugPrint(userMap.toString());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userMap),
      );

      if (response.statusCode == 201) {
        debugPrint('User created successfully');
        return true;
      } else {
        debugPrint('Failed to create user. Status code: ${response.statusCode}');

        var result=jsonDecode(response.body);
        debugPrint('Response body: ${result['email'][0]}');
        ScaffoldMessenger.of(context)
            .showSnackBar(
           SnackBar(
            content: Text('${result['email'][0]}'),
          ),
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error creating user: $e');
      return false;
    }
  }

  static Future<List<AthleteModel>> fetchAllAthletes(String accessToken) async {
    try {
      const String apiUrl = '$serverUrl/auth/athlete';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<AthleteModel> athletes = data
            .map((athleteJson) => AthleteModel.fromJson(athleteJson))
            .toList();
        return athletes;
      } else {
        debugPrint(
            "Failed to fetch athletes. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching athletes: $e");
      return [];
    }
  }

  Future<AthleteModel?> fetchAthleteDetails(
      String accessToken, int? userId) async {
    final String apiUrl = '$serverUrl/auth/athlete/$userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        Map<String, dynamic> userDetailsMap = json.decode(response.body);
        AthleteModel athleteData = AthleteModel.fromJson(userDetailsMap);
        debugPrint('Athlete data: ${athleteData.username}');
        return athleteData;
      } else {
        debugPrint(
            'Failed to fetch user details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      return null;
    }
  }



  static Future<List<CoachModel>> fetchAllCoaches(String accessToken) async {
    const String apiUrl = '$serverUrl/auth/coach/?years_of_coaching=&sport=boxing&gender=&location=';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      debugPrint(" here is the coaches results ${response.body}");

      if (response.statusCode == 200) {
        debugPrint(response.toString());
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('results')) {
          List<dynamic> coachJsonList = responseData['results'];
          List<CoachModel> coaches = coachJsonList.map((json) => CoachModel.fromJson(json)).toList();
          return coaches;
        } else {
          throw Exception('API response is missing the "results" property');
        }
      } else {
        throw Exception(
            'Failed to load coaches. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching coaches: $e');
      throw e;
    }
  }

  Future<void> updateCoachDetails(
      CoachModel updatedCoach, String imagePath, String accessToken) async {
    final String apiUrl =
        '$serverUrl/auth/coach/${updatedCoach.id}/';

    try {
      var request = http.MultipartRequest(
        "PATCH",
        Uri.parse(apiUrl),
      );
      request.fields.addAll(updatedCoach.toJsonString());
      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('profile_image', imagePath));
      }
      request.headers.addAll(<String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
      request.send().then((response) async {
        if (response.statusCode == 200) {
          debugPrint('Coach details updated successfully');
        } else {
          debugPrint(
              'Failed to update coach details. Status code: ${response.statusCode}');
          debugPrint('Response body: ${await response.stream.bytesToString()}');
        }
      });
    } catch (e) {
      debugPrint('Error updating coach details: $e');
    }
  }

  Future<CoachModel?> fetchCoachDetails(String accessToken, int? userId) async {
    final String apiUrl = '$serverUrl/auth/coach/$userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> coachDetailsMap = jsonDecode(response.body);
        CoachModel coachData = CoachModel.fromJson(coachDetailsMap);
        print('Coach data: ${coachData.toJson()}');
        return coachData;
      } else {
        print(
            'Failed to fetch coach details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching coach details: $e');
      return null;
    }
  }

  Future<bool> createCoach(CoachModel coach,BuildContext? context) async {
    const String apiUrl = '$serverUrl/auth/create-coach/';

    final Map<String, dynamic> coachMap = coach.toJsonCreateCoach();
    debugPrint("~~~~~~~~~~~~~~~~~~~~~~~~~$coachMap");
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(coachMap),
      );
      if (response.statusCode == 201) {
        print('Coach created successfully');
        return true;
      } else {
        print('Failed to create coach. Status code: ${response.statusCode}');
        var resut=jsonDecode(response.body);
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context!).showSnackBar( SnackBar(
              content:
              Text('${resut['username'][0]}'),
            ));
        return false;
      }
    } catch (e) {
      print('Error creating coach: $e');
      return false;
    }
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    final url = Uri.parse('$serverUrl/auth/forgot-password/');

    final Map<String, String> requestData = {
      'email': email,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Password reset email sent successfully.');
    } else {
      print('Error sending password reset email: ${response.statusCode}');
      print(response.body);
    }
  }

}
