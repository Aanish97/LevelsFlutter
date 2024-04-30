class CoachModel {
  int? id;
  List<SportType>? sportTypes;
  List<dynamic>? answers;
  String? password;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  bool? isStaff;
  bool? isActive = true;
  DateTime? dateJoined;
  String? email;
  String? name;
  DateTime? birthdate;
  String? profileImage;
  String? phoneNumber;
  String? bio;
  int? yearsOfTraining;
  int? yearsOfCoaching;
  bool? professionalFighter;
  String? location;
  int? hourlyRate;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  CoachModel({
    this.id,
    this.sportTypes,
    this.answers,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.email,
    this.name,
    this.birthdate,
    this.profileImage,
    this.phoneNumber,
    this.bio,
    this.yearsOfTraining,
    this.yearsOfCoaching,
    this.professionalFighter,
    this.location,
    this.hourlyRate,
    this.groups,
    this.userPermissions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport_types':
          sportTypes?.map((sportType) => sportType.toJson()).toList(),
      'answers': answers,
      'password': password,
      'last_login': lastLogin?.toIso8601String(),
      'is_superuser': isSuperuser,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'is_staff': isStaff,
      'is_active': isActive,
      'date_joined': dateJoined?.toIso8601String(),
      'email': email,
      'name': name,
      'birthdate': birthdate?.toIso8601String(),
      'phone_number': phoneNumber,
      'bio': bio,
      'years_of_training': yearsOfTraining,
      'years_of_coaching': yearsOfCoaching,
      'professional_fighter': professionalFighter,
      'location': location,
      'hourly_rate': hourlyRate,
      'groups': groups,
      'user_permissions': userPermissions,
    };
  }

  Map<String, String> toJsonString() {
    Map<String, String> stringMap = {};
    toJsonCreateCoach().forEach((key, value) {
      if (value is String) {
        stringMap[key] = value;
      } else {
        stringMap[key] = value.toString();
      }
    });
    return stringMap;
  }

  Map<String, dynamic> toJsonCreateCoach() {
    return {
      'password': password,
      'username': username,
      'email': email,
      'name': name,
      'bio': bio,
      'phone_number': phoneNumber,
      'years_of_training': yearsOfTraining,
      'years_of_coaching': yearsOfCoaching,
      'location': location,
      'hourly_rate': hourlyRate,
    };
  }

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    return CoachModel(
      id: json['id'],
      sportTypes: json['sport_types'] != null
          ? List<SportType>.from(
              json['sport_types'].map((st) => SportType.fromJson(st)))
          : [],
      answers:
          json['answers'] != null ? List<dynamic>.from(json['answers']) : [],
      password: json['password'],
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      isSuperuser: json['is_superuser'] ?? false,
      username: json['username'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      isStaff: json['is_staff'] ?? false,
      isActive: json['is_active'] ?? true,
      dateJoined: json['date_joined'] != null
          ? DateTime.parse(json['date_joined'])
          : null,
      email: json['email'],
      name: json['name'],
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      profileImage: json['profile_image'] ?? "",
      phoneNumber: json['phone_number'],
      bio: json['bio'] ?? "",
      yearsOfTraining: json['years_of_training'],
      yearsOfCoaching: json['years_of_coaching'],
      professionalFighter: json['professional_fighter'],
      location: json['location'] ?? "",
      hourlyRate: json['hourly_rate'] ?? '0',
      groups: json['groups'] != null ? List<dynamic>.from(json['groups']) : [],
      userPermissions: json['user_permissions'] != null
          ? List<dynamic>.from(json['user_permissions'])
          : [],
    );
  }
}

class SportType {
  int? id;
  String? sport;
  String? level;

  SportType({
    this.id,
    this.sport,
    this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport': sport,
      'level': level,
    };
  }

  factory SportType.fromJson(Map<String, dynamic> json) {
    return SportType(
      id: json['id'] ?? 0,
      sport: json['sport'] ?? '',
      level: json['level'] ?? '',
    );
  }
}
