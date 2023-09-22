// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Caisse {
  String name;
  String type;
  int time;
  String userId;
  String key;
  Caisse({
    required this.name,
    required this.type,
    required this.time,
    required this.userId,
    required this.key,
  });

  Caisse copyWith({
    String? name,
    String? type,
    int? time,
    String? userId,
    String? key,
  }) {
    return Caisse(
      name: name ?? this.name,
      type: type ?? this.type,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'time': time,
      'userId': userId,
      'key': key,
    };
  }

  factory Caisse.fromMap(Map<String, dynamic> map) {
    return Caisse(
      name: map['name'] as String,
      type: map['type'] as String,
      time: map['time'] as int,
      userId: map['userId'] as String,
      key: map['key'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Caisse.fromJson(String source) =>
      Caisse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Caisse(name: $name, type: $type, time: $time, userId: $userId, key: $key)';
  }

  @override
  bool operator ==(covariant Caisse other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.time == time &&
        other.userId == userId &&
        other.key == key;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        time.hashCode ^
        userId.hashCode ^
        key.hashCode;
  }
}
