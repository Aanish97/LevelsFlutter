class AthleteModel {
  int id;
  String password;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  String email;
  String name;
  String birthdate;
  String profileImage;
  String phoneNumber;
  String bio;
  List<String> groups;
  List<String> userPermissions;
  String location;
  DateTime? lastLogin;

  AthleteModel(
      {required this.id,
      required this.password,
      this.lastLogin,
      required this.isSuperuser,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.isStaff,
      required this.isActive,
      required this.dateJoined,
      required this.email,
      required this.name,
      required this.birthdate,
      required this.profileImage,
      required this.phoneNumber,
      required this.bio,
      required this.groups,
      required this.userPermissions,
      required this.location});

  Map<String, String> toJsonString()  {
    Map<String, String> stringMap = {};
    toJsonForUpdateAthlete().forEach((key, value) {
      if (value is String) {
        stringMap[key] = value;
      } else {
        stringMap[key] = value.toString();
      }
    });
    return stringMap;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'last_login': lastLogin?.toIso8601String(),
      'is_superuser': isSuperuser,
      'username': username,
      'first_name': firstName,
      'location': location,
      'last_name': lastName,
      'is_staff': isStaff,
      'is_active': isActive,
      'date_joined': dateJoined.toIso8601String(),
      'email': email,
      'name': name,
      'birthdate': birthdate,
      'profile_image': profileImage,
      'phone_number': phoneNumber,
      'bio': bio,
      'groups': groups,
      'user_permissions': userPermissions,
    };
  }

  Map<String, dynamic> toJsonForCreateAthlete() {
    return {
      'password': password,
      'username': username,
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'location': location
    };
  }

  Map<String, dynamic> toJsonForUpdateAthlete() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'location': location
    };
  }

  factory AthleteModel.fromJson(Map<String, dynamic> json) {
    return AthleteModel(
        id: json['id'] ?? '',
        password: json['password'] ?? '',
        lastLogin: json['last_login'] != null
            ? DateTime.parse(json['last_login'])
            : null,
        isSuperuser: json['is_superuser'] ?? '',
        username: json['username'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        isStaff: json['is_staff'] ?? '',
        isActive: json['is_active'] ?? '',
        dateJoined: DateTime.parse(json['date_joined'] ?? ''),
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        birthdate: json['birthdate'] ?? '',
        profileImage: json['profile_image'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        bio: json['bio'] ?? '',
        groups: List<String>.from(json['groups'] ?? []),
        userPermissions: List<String>.from(json['user_permissions'] ?? []),
        location: json['location'] ?? '');
  }
}