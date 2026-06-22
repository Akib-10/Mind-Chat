
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mind_chat/screen/feature/chatbot_feature.dart';
import 'package:mind_chat/screen/feature/image_feature.dart';
import 'package:mind_chat/screen/feature/translator_feature.dart';
//For adding and decorate cards in home_screen
enum HomeType {aiChatBot, aiImage, aiTranslator}

extension MyHomeType on HomeType{
  //title
  String get title => switch (this){
    HomeType.aiChatBot => 'AI ChatBot',
  HomeType.aiImage => 'AI Image Creator',
  HomeType.aiTranslator => 'Language Translator',
  };

  //lottie
  String get lottie => switch (this){
    HomeType.aiChatBot => 'ai_hand_waving.json',
    HomeType.aiImage => 'ai_play.json',
    HomeType.aiTranslator => 'ai_ask_me.json',
  };

  //for alignment
  bool get leftAlign => switch (this) {
    HomeType.aiChatBot => true,
    HomeType.aiImage => false,
    HomeType.aiTranslator => true,
  };

  //for Padding
  EdgeInsets get padding => switch (this){
    HomeType.aiChatBot => EdgeInsets.zero,
    HomeType.aiImage => const EdgeInsets.all(20),
    HomeType.aiTranslator => EdgeInsets.zero,
  };

  //For Features Navigation
  VoidCallback get onTap => switch (this) {
    HomeType.aiChatBot => () => Get.to(() => const ChatbotFeature()),
    HomeType.aiImage => () => Get.to(() => const ImageFeature()),
    HomeType.aiTranslator => () => Get.to(() => const TranslatorFeature()),
  };

}