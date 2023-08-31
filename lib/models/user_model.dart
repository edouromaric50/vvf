//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/scheduler.dart';

class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final int createdAt;
  final String userId;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
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
          createdAt == other.createdAt &&
          userId == other.userId);

  @override
  int get hashCode =>
      firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'UserModel{'
            'firstname: $firstname,' +
        ' lastname: $lastname,' +
        ' email: $email,' +
        'createdAt: $createdAt,' +
        'userId:$userId,' +
        '}';
  }

  UserModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    int? createdAt,
    String? userId,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
      'createdAt': this.createdAt,
      'userId': this.userId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map["firstname"] as String,
      lastname: map["lastname"] as String,
      email: map["email"] as String,
      createdAt: map["createdAt"] as int,
      userId: map["userId"] as String,
    );
  }
}
