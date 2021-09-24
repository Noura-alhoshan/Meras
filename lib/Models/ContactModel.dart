// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    this.id,
    this.name,
    this.email,
    this.message,
    this.createdAt,
  });

  String? id;
  String? name;
  String? email;
  String? message;
  dynamic createdAt;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        message: json["message"] == null ? null : json["message"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "message": message == null ? null : message,
        "createdAt": createdAt == null ? null : createdAt,
      };
}
