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

  /// ANALYZE A DOCUMENT (PDF or image) WITH AN OPTIONAL QUESTION
  /// Gemini can read PDFs and images directly as inline file data,
  /// so there's no need for a separate text-extraction package.

  Future<ChatMessage> analyzeDocument({
    required File file,
    String userQuestion = '',
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final mimeType = _getMimeType(file.path);

      final hasQuestion = userQuestion.trim().isNotEmpty;

      final promptText = """
      You are an AI Study Tutor helping a student understand an uploaded file.

      ${hasQuestion ? 'The student asked this question about the file:\n"$userQuestion"'
          : 'The student did not ask a specific question, so give a clear, well-organized summary of the file.'
      }

      Read the file carefully and respond clearly and simply, as if explaining to a student.
      If the file contains math, code, or diagrams, explain them step by step.
      """;

      final content = [
        Content.multi([
          TextPart(promptText),
          DataPart(mimeType, bytes),
        ])
      ];

      final response = await _model.generateContent(content);
      final text = response.text ?? "AI could not analyze the document.";

      return ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return ChatMessage(
        text: "Error analyzing document: $e",
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
  }

  /// ANALYZE MULTIPLE FILES (PDF and/or images) + optional text
  /// Use this when the user attaches one or more files (pdf_feature.dart
  /// er jonno). All files + the typed message are sent to Gemini together
  /// in a single request.

  Future<ChatMessage> analyzeDocuments({
    required List<File> files,
    String userText = '',
    }) async {
    try {
      final hasQuestion = userText.trim().isNotEmpty;

      final promptText = """
      You are an AI Study Tutor helping a student with uploaded file(s).

      ${hasQuestion ? 'The student wrote this message along with the file(s):\n"$userText"'
          : 'The student did not type a message, so give a clear, well-organized summary of the file(s).'
      }

      Read all the attached file(s) carefully (they may be PDFs and/or images) and
      respond clearly and simply, as if explaining to a student. If there are
      multiple files, connect them together in your answer when relevant.
      If the file contains math, code, or diagrams, explain step by step.
      """;

      //part gula list korar jonno (1st e text, tarpor sob file)
      final parts = <Part>[TextPart(promptText)];
      for (final file in files) {
        //file ke binary data hisebe porar jonno
        final bytes = await file.readAsBytes();
        //file er type ber korar jonno
        final mimeType = _getMimeType(file.path);
        //new datapath making for adding in path list
        parts.add(DataPart(mimeType, bytes));
      }

      final content = [Content.multi(parts)];

      final response = await _model.generateContent(content);
      final text = response.text ?? "AI could not analyze the file(s).";

      return ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return ChatMessage(
        text: "Error analyzing file(s): $e",
        isUser: false,
        timestamp: DateTime.now(),
      );
    }
  }

  /// Maps a file extension to the mime(file ki type er ta bole dey)
  String _getMimeType(String path) {
    //benge 2 part korar jonno
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      default:
        return 'application/octet-stream';
    }
  }

  /// SUMMARIZE A PDF (kept for backward compatibility, plain text input)
  ///
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

  /// ANALYZE AN IMAGE (Gemini Vision) (kept for backward compatibility)

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

  /// CLEAR CONVERSATION MEMORY

  void clearChat() {
    _memory = "";
  }
}