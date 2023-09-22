import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/controllers/user_controller.dart';
import 'package:testproject/models/category_model.dart';
import 'package:testproject/utils/providers.dart';

final getAllCats = StreamProvider<List<Category>>(
    (ref) => CategoryController(ref).getUserCategory());

class CategoryController {
  final Ref ref;

  CategoryController(this.ref);

  Future<String> addCategory(Category category) async {
    try {
      await ref.read(catRef).add(category.toMap());
    } catch (e) {
      return e.toString();
    }
    return "";
  }

  Stream<List<Category>> getUserCategory() {
    return ref
        .read(catRef)
        .where("userId", isEqualTo: ref.read(me).userId)
        .snapshots()
        .map((value) {
      List<Category> cats = [];
      value.docs.forEach((element) {
        var c = Category.fromMap(element.data() as Map<String, dynamic>)
            .copyWith(key: element.id);
        cats.add(c);

        // log(c);
      });

      var c1 = cats.where((element) => element.type.isEmpty).toList();
      var c2 = cats
          .where((element) => element.type == CatType.other.toString())
          .toList();
      var c3 = cats
          .where((element) => element.type == CatType.projet.toString())
          .toList();

      c1.addAll(c3);
      c1.addAll(c2);

      return c1;
    });
  }

  setupCategory(String userId) async {
    int time = DateTime.now().millisecondsSinceEpoch;
    List<Category> cats = [
      Category(
          nom: "Éducation",
          iconData: 58713,
          type: "",
          userId: userId,
          key: "",
          time: time,
          colorR: 158,
          colorG: 158,
          colorA: 255,
          colorB: 158),
      Category(
          nom: "Santé",
          iconData: 62688,
          type: "",
          userId: userId,
          key: "",
          time: time,
          colorR: 76,
          colorG: 175,
          colorA: 255,
          colorB: 80),
      Category(
          nom: "Sport",
          iconData: 983481,
          type: CatType.projet.toString(),
          userId: userId,
          key: "",
          time: time,
          colorR: 156,
          colorG: 39,
          colorA: 255,
          colorB: 176),
      Category(
          nom: "Confidentialité",
          iconData: 61505,
          type: CatType.other.toString(),
          userId: userId,
          key: "",
          time: time,
          colorR: 121,
          colorG: 85,
          colorA: 255,
          colorB: 72),
    ];
    WriteBatch batch = getFirestore().batch();
    cats.forEach((cat) {
      String key = ref.read(catRef).doc().id;
      batch.set(ref.read(catRef).doc(key), cat.toMap());
    });
    await batch.commit();
  }
}

enum CatType {
  auto,
  other,
  projet,
}
