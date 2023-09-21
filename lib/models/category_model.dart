// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  String nom;
  int iconData;
  String type;
  String userId;
  String key;
  int time;
  int colorR;
  int colorG;
  int colorA;
  int colorB;
  Category({
    required this.nom,
    required this.iconData,
    required this.type,
    required this.userId,
    required this.key,
    required this.time,
    required this.colorR,
    required this.colorG,
    required this.colorA,
    required this.colorB,
  });

  Category copyWith({
    String? nom,
    int? iconData,
    String? type,
    String? userId,
    String? key,
    int? time,
    int? colorR,
    int? colorG,
    int? colorA,
    int? colorB,
  }) {
    return Category(
      nom: nom ?? this.nom,
      iconData: iconData ?? this.iconData,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      key: key ?? this.key,
      time: time ?? this.time,
      colorR: colorR ?? this.colorR,
      colorG: colorG ?? this.colorG,
      colorA: colorA ?? this.colorA,
      colorB: colorB ?? this.colorB,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'iconData': iconData,
      'type': type,
      'userId': userId,
      'key': key,
      'time': time,
      'colorR': colorR,
      'colorG': colorG,
      'colorA': colorA,
      'colorB': colorB,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      nom: map['nom'] as String,
      iconData: map['iconData'] as int,
      type: map['type'] as String,
      userId: map['userId'] as String,
      key: map['key'] ?? "",
      time: map['time'] as int,
      colorR: map['colorR'] as int,
      colorG: map['colorG'] as int,
      colorA: map['colorA'] as int,
      colorB: map['colorB'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(nom: $nom, iconData: $iconData, type: $type, userId: $userId, key: $key, time: $time, colorR: $colorR, colorG: $colorG, colorA: $colorA, colorB: $colorB)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.nom == nom &&
        other.iconData == iconData &&
        other.type == type &&
        other.userId == userId &&
        other.key == key &&
        other.time == time &&
        other.colorR == colorR &&
        other.colorG == colorG &&
        other.colorA == colorA &&
        other.colorB == colorB;
  }

  @override
  int get hashCode {
    return nom.hashCode ^
        iconData.hashCode ^
        type.hashCode ^
        userId.hashCode ^
        key.hashCode ^
        time.hashCode ^
        colorR.hashCode ^
        colorG.hashCode ^
        colorA.hashCode ^
        colorB.hashCode;
  }
}
