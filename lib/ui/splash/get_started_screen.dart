import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:dealz/translate/translations.dart';
import 'package:dealz/ui/onBoadring/welcome_screen.dart';
import 'package:flutter/material.dart';

class GetStartedscreen extends StatefulWidget {
  const GetStartedscreen({super.key});

  @override
  State<GetStartedscreen> createState() => _GetStartedscreenState();
}

class _GetStartedscreenState extends State<GetStartedscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    Assets.images.logo.path,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Text(
                  Translations.of(context).text("getStartedScreenTitle"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                ButtonWidget(
                  type: ButtonType.primary,
                  title: Translations.of(context).text("getStartedScreenButtonTitle"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (_) => WelcomeScreen()), (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
