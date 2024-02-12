// ignore_for_file: unused_element, library_private_types_in_public_api, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:convert';
import 'package:chatbotapp/Screens/Messages.dart';
import 'package:chatbotapp/Screens/welcome_screen.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatbotapp/Screens/panel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;


class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> predefinedMessages = [
  '31'.tr,
  '9'.tr,
  '15'.tr,
  '33'.tr,
  
];
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('21'.tr),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('22'.tr),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('23'.tr),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final auth = FirebaseAuth.instance;
                          await auth.signOut();
                          Navigator.pushNamed(
                              context, WelcomeScreen.screenRoute);
                          Fluttertoast.showToast(
                            msg: '29'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                const Color.fromARGB(255, 22, 232, 54),
                            textColor: Colors.white,
                            fontSize: 15,
                          );
                        },
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
        .loadString('assets/dialog_flow_auth.json');
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(145, 184, 142, 1),
          title: Row(
            children: [
              IconButton(
                onPressed: () async {
                  final auth = FirebaseAuth.instance;
                  await auth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                  Fluttertoast.showToast(
                    msg: '29'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color.fromARGB(255, 22, 232, 54),
                    textColor: Colors.white,
                    fontSize: 15,
                  );
                },
                icon: const Icon(Icons.logout),
                color: const Color(0xff2e386b),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('30'.tr),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  itemCount: predefinedMessages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // إرسال السؤال المحدد إلى شاشة الدردشة
                                        sendMessage(predefinedMessages[index]);
                                        Navigator.pop(
                                            context); // إغلاق الـDialog
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text(predefinedMessages[index]),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.menu),
                      color: const Color.fromARGB(255, 8, 8, 8),
                    ),
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
      ),
    );
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      messages.insert(0, {'message': message, 'isUserMessage': isUserMessage});
    });
  }

  Future<void> createBalanceTable() async {
    String? UserE = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection('balance').add({
      'id': UserE,
      'balance': 1000000,
    });
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      // Check if the question contains the word "balance"
      if (text.contains('balance') ||
          text.contains('رصيد') ||
          (text.contains("كم") && text.contains('حساب')) ||
          (text.contains("حساب") && text.contains('يبلغ')) ||
          (text.contains("حساب") && text.contains('باقي'))) {
        // Retrieve the balance value from Firestore
        String? UserEm = FirebaseAuth.instance.currentUser!.email;
        String documentId = UserEm!;
        DocumentSnapshot<Map<String, dynamic>> balanceSnapshot =
            await FirebaseFirestore.instance
                .collection('userBal')
                .doc(documentId)
                .get();

        if (balanceSnapshot.exists) {
          String balance = balanceSnapshot.get('balance').toString();
          final autoResponse = Message(
            text: DialogText(text: ['Your balance is $balance']),
          );
          setState(() {
            addMessage(autoResponse);
          });
        } else {
          final autoResponse = Message(
            text: DialogText(text: const ['No balance found']),
          );
          setState(() {
            addMessage(autoResponse);
          });
        }
      } else {
        DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );

        if (response.message == null) return;

        setState(() {
          addMessage(response.message!);
        });
      }

      // Scroll to the bottom of the message list
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}