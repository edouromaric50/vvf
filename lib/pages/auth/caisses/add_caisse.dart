import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:testproject/components/app_button.dart';
import 'package:testproject/components/app_input.dart';
import 'package:testproject/components/app_text.dart';
import 'package:testproject/controllers/user_controller.dart';
import 'package:testproject/models/caisse_model.dart';
import 'package:testproject/models/category_model.dart';
import 'package:testproject/utils/app_const.dart';
import 'package:testproject/utils/app_func.dart';
import 'package:testproject/utils/providers.dart';

class AddCaisse extends ConsumerStatefulWidget {
  const AddCaisse({super.key});

  @override
  ConsumerState createState() => _AddCaisseState();
}

class _AddCaisseState extends ConsumerState<AddCaisse> {
  var key = GlobalKey<FormState>();
  var isLoading = false;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.caisseColor,
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
                helperText: "Nom; Ex Entreprise ou famille ",
                hintText: "Nom de la caisse ",
                validation: ValidationBuilder(requiredMessage: "Non requis"),
              ),
              AppButtonRound(
                backgroundColor: AppColor.caisseColor,
                width: 320,
                text: "Ajouter",
                onTap: () async {
                  if (key.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    Caisse c = Caisse(
                        name: nameController.text.trim(),
                        type: "",
                        time: DateTime.now().millisecondsSinceEpoch,
                        userId: ref.read(me).userId,
                        key: "");

                    String error =
                        await ref.read(caisseController).addCaisse(c);
                    setState(() {
                      isLoading = false;
                    });
                    if (error.isEmpty) {
                      showSuccessError(context, "Caisse ajoutée avec succès",
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
}
