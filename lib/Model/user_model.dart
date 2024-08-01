import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

  UserModel({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  String imageUrl;
  String name;
  String phone;
  String email;
  String id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        imageUrl: json["imageUrl"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "email": email,
        "phone": phone,
      };

  UserModel copyWith({
    String? name,imageUrl,phone,
  }) =>
      UserModel(
        id: id,
        phone: phone?? this.phone,
        name: name ?? this.name,
        email: email,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
