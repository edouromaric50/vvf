import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:testproject/components/app_button.dart';
import 'package:testproject/components/app_input.dart';
import 'package:testproject/components/app_text.dart';
import 'package:testproject/controllers/user_controller.dart';
import 'package:testproject/models/category_model.dart';
import 'package:testproject/utils/app_const.dart';
import 'package:testproject/utils/app_func.dart';
import 'package:testproject/utils/providers.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({super.key});

  @override
  ConsumerState createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  var key = GlobalKey<FormState>();
  var isLoading = false;
  Color currentColor = AppColor.projeColor; // Initial color
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.catgColor,
        title: const AppText(
          "Nouvelle catégorie",
          color: Colors.white,
          size: 18,
        ),
      ),
      body: Form(
          key: key,
          child: Column(
            children: [
              SpacerHeight(),
              SimpleFilledFormField(
                controller: nameController,
                helperText: "Nom; Ex Restauration ou Sport ",
                hintText: "Nom de catégorie",
                validation: ValidationBuilder(requiredMessage: "Non requis"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const SpacerHeight(),
                      TextButton(
                        onPressed: () => pickIcon(),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.catgColor,
                        ),
                        child: AppText(
                          "Icône de la catégorie",
                          color: AppColor.white,
                        ),
                      ),
                      const SpacerHeight(),
                      InkWell(
                        onTap: () => pickIcon(),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all()),
                          child: _icon == null
                              ? null
                              : Icon(
                                  _icon!,
                                  size: 80,
                                  color: currentColor,
                                ),
                        ),
                      ),
                      const SpacerHeight(),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () => openColorPickerDialog(context),
                        child: AppText(
                          "Couleur de la catégorie",
                          color: AppColor.white,
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.catgColor,
                        ),
                      ),
                      const SpacerHeight(),
                      InkWell(
                        onTap: () => openColorPickerDialog(context),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            backgroundColor: currentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SpacerHeight(),
                ],
              ),
              AppButtonRound(
                backgroundColor: AppColor.primary,
                width: 320,
                text: "Ajouter",
                onTap: () async {
                  if (key.currentState!.validate()) {
                    if (_icon == null) {
                      showSnackbar(context, "Veuillez choisir une Icône");
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    Category c = Category(
                        nom: nameController.text.trim(),
                        iconData: _icon!.codePoint,
                        type: "",
                        key: "",
                        userId: ref.read(me).userId,
                        time: DateTime.now().millisecondsSinceEpoch,
                        colorR: currentColor.red,
                        colorG: currentColor.green,
                        colorA: currentColor.alpha,
                        colorB: currentColor.blue);

                    String error = await ref.read(catController).addCategory(c);
                    setState(() {
                      isLoading = false;
                    });
                    if (error.isEmpty) {
                      showSuccessError(context, "Categorie ajoutée avec succès",
                          onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    } else {}
                  }
                },
                isLoading: isLoading,
              ),
            ],
          )),
    );
  }

  IconData? _icon;

  pickIcon() async {
    _icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    setState(() {});
  }

  void openColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisissez une couleur '),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                setState(() {
                  currentColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
