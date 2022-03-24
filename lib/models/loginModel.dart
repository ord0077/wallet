// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        // required this.token,
        required this.user,
    });

    // String token;
    User user;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        // token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        // "token": token,
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        this.mobileNo,
        required this.roleId,
        required this.countryId,
        this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
        required this.wallet,
        required this.roleType,
    });

    int id;
    String firstName;
    String lastName;
    String email;
    dynamic mobileNo;
    String roleId;
    String countryId;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String wallet;
    String roleType;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        roleId: json["role_id"],
        countryId: json["country_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        wallet: json["wallet"],
        roleType: "Shopkeeper"/*json["role_type"]*/,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_no": mobileNo,
        "role_id": roleId,
        "country_id": countryId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "wallet": wallet,
        "role_type": "Shopkeeper"/*roleType*/,
    };
}
