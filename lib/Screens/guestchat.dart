// ignore_for_file: library_private_types_in_public_api, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'package:chatbotapp/Screens/Messages.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:chatbotapp/Screens/panel.dart';

class GuestScreen extends StatefulWidget {
  static const String screenRoute = 'guest_screen';
  const GuestScreen({Key? key}) : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    loadDialogFlow().then((instance) {
      setState(() {
        dialogFlowtter = instance;
      });
    }).catchError((error) {
      print('Error initializing DialogFlowtter: $error');
    });
    super.initState();
  }

  Future<DialogFlowtter> loadDialogFlow() async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/geustbanking.json');
    final jsonData = json.decode(jsonString);

    return DialogFlowtter.fromJson(jsonData);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(145, 184, 142, 1),
        title: Row(
          children: [
            Image.asset(
              'images/ChatBotLogo.png',
              height: 100,
            ),
            const Text(
              'ChatBot',
              style: TextStyle(
                  color: Color(0xff2e386b), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, static_panel.screenRoute);
              },
              child: const Text(
                'FAQs',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff2e386b),
                ),
              ))
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: MessagesScreen(
              messages: messages,
              scrollController: _scrollController,
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  )),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: const Color.fromARGB(255, 79, 155, 74),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      messages.insert(0, {'message': message, 'isUserMessage': isUserMessage});
    });
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );

      if (response.message == null) return;

      setState(() {
        addMessage(response.message!);
        // Scroll to the bottom of the messages list
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      });
    }
  }
}
