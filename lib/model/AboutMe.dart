
import 'dart:convert';

AboutMe aboutMeFromJson( str) => AboutMe.fromJson(json.decode(str));

String aboutMeToJson(AboutMe data) => json.encode(data.toJson());

class AboutMe {
  String success;
  String message;
  Data data;

  AboutMe({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AboutMe.fromJson(Map<String, dynamic> json) => AboutMe(
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
