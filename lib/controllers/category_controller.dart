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
        .where("UserId", isEqualTo: ref.read(me).userId)
        .snapshots()
        .map((value) {
      List<Category> cats = [];
      value.docs.forEach((element) {
        cats.add(Category.fromMap(element.data() as Map<String, dynamic>)
            .copyWith(key: element.id));
      });
      return cats;
    });
  }
}
