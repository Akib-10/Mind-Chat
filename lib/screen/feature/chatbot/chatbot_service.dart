import 'package:google_generative_ai/google_generative_ai.dart';
import 'chat_message.dart';

class ChatbotService {
  static const String _apiKey = 'API KEY';
  late final GenerativeModel _model;
  late ChatSession _chat;

  ChatbotService() {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }


}