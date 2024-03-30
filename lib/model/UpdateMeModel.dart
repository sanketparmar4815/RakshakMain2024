// To parse this JSON data, do
//
//     final updateMeModel = updateMeModelFromJson(jsonString);

import 'dart:convert';

UpdateMeModel updateMeModelFromJson(str) => UpdateMeModel.fromJson(json.decode(str));

String updateMeModelToJson(UpdateMeModel data) => json.encode(data.toJson());

class UpdateMeModel {
  String success;
  String message;
  Data data;

  UpdateMeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  UpdateMeModel copyWith({
    String? success,
    String? message,
    Data? data,
  }) =>
      UpdateMeModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UpdateMeModel.fromJson(Map<String, dynamic> json) => UpdateMeModel(
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
  User user;

  Data({
    required this.user,
  });

  Data copyWith({
    User? user,
  }) =>
      Data(
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
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

  User copyWith({
    String? id,
    String? name,
    List<dynamic>? location,
    String? role,
    String? number,
    int? v,
    String? fcmToken,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        role: role ?? this.role,
        number: number ?? this.number,
        v: v ?? this.v,
        fcmToken: fcmToken ?? this.fcmToken,
      );

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
