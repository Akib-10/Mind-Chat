import 'package:google_generative_ai/google_generative_ai.dart';
import 'chat_message.dart';

class ChatbotService {
  static const String _apiKey = 'AQ.Ab8RN6LMYRz_ZItBVKsy-XKMfAfORoh0xF-ZIpXWhp4Nr7qHYA';

  late final GenerativeModel _model;
  late ChatSession _chat;

  ChatbotService() {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  void clearChat() {
    _chat = _model.startChat();
  }

  Future<ChatMessage> sendMessage(String text) async {
    try {
      final response = await _chat.sendMessage(Content.text(text));
      return ChatMessage(
        text: response.text ?? 'No response received.',
        isUser: false,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return ChatMessage(
        text: '⚠️ Error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
  }
}