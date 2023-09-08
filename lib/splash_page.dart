//import 'dart:ffi';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/components/app_image.dart';
import 'package:testproject/components/app_text.dart';
//import 'package:testproject/controllers/user_controller.dart';
import 'package:testproject/home_page.dart';
import 'package:testproject/pages/auth/login_page.dart';
import 'package:testproject/utils/app_func.dart';
//import 'package:testproject/utils/app_pref.dart';
import 'package:testproject/utils/providers.dart';

//ref.read()
final nbTimes = Provider<int>((ref) => 50);
final darkModeEnabled = StateProvider<bool>((ref) => false);

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    setupTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: getSize(context).width,
        height: getSize(context).height,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const AppImage(
                    url: "assets/img/logo.png",
                    width: 250,
                    height: 250,
                  )),
            ),
            const Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  // ignore: unnecessary_const
                  children: [
                    AppText(
                      "Votre assistante financière",
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoActivityIndicator(),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void setupTimer() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      //  bool homeP = PreferenceHelper.getBool("home");
      //
      ref.read(firebaseMessaging).subscribeToTopic("all_users");
      // String? token = await ref.read(firebaseMessaging).getToken();
      // if(user...is..femme)
      // ref.read(firebaseMessaging).subscribeToTopic("all_femmes");

      if (ref.read(mAuth).currentUser == null) {
        navigateToWidget(context, const LoginPage());
      } else {
        await ref.read(userController).setupUser();
        // @override
        // void reassemmble() {
        //   super.reassemble();
        // }

        // var user = await ref.read(userController).getCurrentUser();
        // ref.read(me.notifier).state = user;
        // //log(ref.read(mAuth).currentUser!.uid);

        // ignore: use_build_context_synchronously
        navigateToWidget(context, const HomePage(), back: false);
      }
    });
  }
}
