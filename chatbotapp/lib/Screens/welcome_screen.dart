// ignore_for_file: library_private_types_in_public_api

import 'package:chatbotapp/Screens/guestchat.dart';
import 'package:chatbotapp/Screens/login_screen.dart';
import 'package:chatbotapp/Screens/registration_screen.dart';
import 'package:chatbotapp/local/local_controller.dart';
import 'package:chatbotapp/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('27'.tr),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('25'.tr),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('23'.tr),
                      ),
                      ElevatedButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text('24'.tr),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )) ??
        false;
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('26'.tr),
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('العربية'),
              onTap: () {
                Get.find<MyLocalController>().changeLang('ar');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language,),
              title: const Text('English'),
              onTap: () {
                Get.find<MyLocalController>().changeLang('en');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(145, 184, 142, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(145, 184, 142, 1),
          leading: IconButton(
            icon: const Icon(Icons.language, size: 35, color:Color.fromRGBO(46, 56, 107, 1),),
            onPressed: _showLanguageDialog,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350,
                        child: Image.asset('images/ChatBotLogo.png'),
                      ),
                    ],
                  ),
                  MyButton(
                    color: const Color.fromRGBO(46, 56, 107, 1),
                    title: '1'.tr,
                    onPressed: () {
                      Navigator.pushNamed(context, LogInScreen.screenRoute);
                    },
                  ),
                  MyButton(
                    color: const Color(0xff2e386b),
                    title: '2'.tr,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RegistrationScreen.screenRoute);
                    },
                  ),
                  MyButton(
                    color: const Color(0xff2e386b),
                    title: '3'.tr,
                    onPressed: () {
                      Navigator.pushNamed(context, GuestScreen.screenRoute);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
