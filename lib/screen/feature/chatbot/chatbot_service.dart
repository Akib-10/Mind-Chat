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

  /// SEND & returns a ChatMessage
  Future<ChatMessage> sendMessage(String userMessage) async {
    try {
      //Ai er behavior and personality er jonno
      String prompt = """You are an AI Study Tutor.
Help students with:
- math explanation
- programming help
- exam preparation tips
- note summarization
Explain answers clearly and simply.

Conversation history:
$_memory

Student question:
$userMessage
""";
      //gemini ke request pathanor jonno
      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? "AI could not generate a response.";

      //memory update korar jonno
      _memory += "\nStudent: $userMessage\nAI: $text";

      return ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      );

    } catch (e) {
      return ChatMessage(
        text: "Error generating AI response: $e",
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
  }


  //eikhan theke pore arek din
  /// SUMMARIZE A PDF
  //////////////////////////////////////////////////////////
  Future<String> summarizePDF(String pdfText) async {
    try {
      String prompt = """Summarize the following study notes clearly and concisely for a student:
$pdfText
""";

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? "Could not summarize PDF.";

    } catch (e) {
      return "Error summarizing PDF: $e";
    }
  }

  //////////////////////////////////////////////////////////
  /// ANALYZE AN IMAGE (Gemini Vision)
  //////////////////////////////////////////////////////////
  Future<String> analyzeImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();

      final content = [
        Content.multi([
          TextPart("""Explain the content of this image.
If it contains:
- math diagrams
- programming code
- study notes
Explain it simply for a student."""),
          DataPart("image/png", bytes),
        ])
      ];

      final response = await _model.generateContent(content);
      return response.text ?? "Could not analyze image.";

    } catch (e) {
      return "Error analyzing image: $e";
    }
  }

  //////////////////////////////////////////////////////////
  /// CLEAR CONVERSATION MEMORY
  //////////////////////////////////////////////////////////
  void clearChat() {
    _memory = "";
  }
}