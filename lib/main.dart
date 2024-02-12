import 'package:chatbotapp/local/local.dart';
import 'package:chatbotapp/local/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/welcome_screen.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatbotapp/Screens/chat_screen.dart';
import 'package:chatbotapp/Screens/registration_screen.dart';
import 'Screens/panel.dart';
import 'Screens/guestchat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBot',
      theme: ThemeData(
          //brightness: Brightness.dark,
          useMaterial3: true),
      initialRoute: WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        RegistrationScreen.screenRoute: (context) => const RegistrationScreen(),
        LogInScreen.screenRoute: (context) => const LogInScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
        static_panel.screenRoute: (context) => const static_panel(),
        GuestScreen.screenRoute: (context) => const GuestScreen(),
      },
      locale: const Locale('en'),
      translations: MyLocal(),
      //home: Home(),
    );
  }
}
