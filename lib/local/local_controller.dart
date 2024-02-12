import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyLocalController extends GetxController {
  
  void changeLang(String codelang) {
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
    
  }
}