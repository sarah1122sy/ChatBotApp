import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class static_panel extends StatefulWidget {
  static const String screenRoute = 'panel';
  const static_panel({super.key});

  @override
  State<static_panel> createState() => _panelState();
}

Future<void> getMaxQuestions() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('questions')
      .orderBy('timestamp', descending: true)
      .limit(10)
      .get();

  List<String> maxQuestions = [];
  for (var doc in querySnapshot.docs) {
    String question = doc.get('question');
    maxQuestions.add(question);
  }
}

// ignore: camel_case_types
class _panelState extends State<static_panel> {
  bool f1 = false;
  bool f2 = false;
  bool f3 = false;
  bool f4 = false;
  bool f5 = false;
  bool f6 = false;
  ExpansionPanelList getpanelList() {
    return (ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          if (panelIndex == 0) {
            f1 = isExpanded;
          }
          if (panelIndex == 1) {
            f2 = isExpanded;
          }
          if (panelIndex == 2) {
            f3 = isExpanded;
          }
          if (panelIndex == 3) {
            f4 = isExpanded;
          }
          if (panelIndex == 4) {
            f5 = isExpanded;
          }
          if (panelIndex == 5) {
            f6 = isExpanded;
          }
        });
      },
      dividerColor: const Color.fromRGBO(145, 184, 142, 1),
      elevation: 1,
      animationDuration: const Duration(seconds: 1),
      expandedHeaderPadding: const EdgeInsets.all(10),
      expandIconColor: const Color.fromRGBO(145, 184, 142, 1),
      children: [
        ExpansionPanel(
            isExpanded: f1,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '9'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '10'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
        ExpansionPanel(
            isExpanded: f2,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '11'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '12'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
        ExpansionPanel(
            isExpanded: f3,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '13'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '14'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
        ExpansionPanel(
            isExpanded: f4,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '15'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '16'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
        ExpansionPanel(
            isExpanded: f5,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '17'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '18'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
        ExpansionPanel(
            isExpanded: f6,
            headerBuilder: (context, isExpanded) {
              return (ListTile(
                title: Text(
                  '19'.tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
            },
            body: ListTile(
              title: Text(
                '20'.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18),
              ),
            )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(145, 184, 142, 1),
            title: Row(
              children: [
                Image.asset(
                  'images/ChatBotLogo.png',
                  height: 75,
                ),
                Text(
                  '8'.tr,
                  style: const TextStyle(
                      color: Color(0xff2e386b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Column(
                  children: [getpanelList()],
                ),
              ),
            ),
          ),
        )));
  }
}
