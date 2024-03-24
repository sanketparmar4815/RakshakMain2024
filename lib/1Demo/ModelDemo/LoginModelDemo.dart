// To parse this JSON data, do
//
//     final loginModel1 = loginModel1FromJson(jsonString);

import 'dart:convert';
//
// LoginModel1 loginModel1FromJson(String str) => LoginModel1.fromJson(json.decode(str));
//
// String loginModel1ToJson(LoginModel1 data) => json.encode(data.toJson());

class LoginModel1 {
  String success;
  String message;
  Data data;

  LoginModel1({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel1.fromJson(Map<String, dynamic> json) => LoginModel1(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String token;
  User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String name;
  List<dynamic> location;
  String role;
  String number;
  int v;
  String fcmToken;

  User({
    required this.id,
    required this.name,
    required this.location,
    required this.role,
    required this.number,
    required this.v,
    required this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    location: List<dynamic>.from(json["location"].map((x) => x)),
    role: json["role"],
    number: json["number"],
    v: json["__v"],
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": List<dynamic>.from(location.map((x) => x)),
    "role": role,
    "number": number,
    "__v": v,
    "fcm_token": fcmToken,
  };
}
