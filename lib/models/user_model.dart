//import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/scheduler.dart';

class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  late final String fcm;
  final int createdAt;
  late final String userId;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.fcm,
    required this.createdAt,
    required this.userId,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          firstname == other.firstname &&
          lastname == other.lastname &&
          email == other.email &&
          fcm == other.fcm &&
          createdAt == other.createdAt &&
          userId == other.userId);

  @override
  int get hashCode =>
      firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      fcm.hashCode ^
      createdAt.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'UserModel{firstname: $firstname, lastname: $lastname, email: $email,createdAt: $createdAt,fcm: $fcm,userId:$userId,}';
  }

  UserModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? fcm,
    int? createdAt,
    String? userId,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      fcm: fcm ?? this.fcm,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'fcm': fcm,
      'createdAt': createdAt,
      'userId': userId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map["firstname"] as String,
      lastname: map["lastname"] as String,
      email: map["email"] as String,
      fcm: map["fcm"] as String,
      createdAt: map["createdAt"] as int,
      userId: map["userId"] as String,
    );
  }

  static initial() {
    return UserModel(
        firstname: "",
        lastname: "",
        email: "",
        fcm: "",
        createdAt: DateTime.now().millisecondsSinceEpoch,
        userId: "");
  }
}
