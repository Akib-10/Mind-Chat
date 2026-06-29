import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'chat_message.dart';

class ChatbotService {

  //GenerativeModel eita api er sathe kotha bole
  late final GenerativeModel _model;

  /// MEMORY rakhar jonno
  String _memory = "";

  /// CONSTRUCTOR
  ChatbotService() {
    _model = GenerativeModel(
      model: "gemini-2.5-flash",
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
    );
  }


}