import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TranslatorService {
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: _apiKey,
  );

  /// Translates [text] from [fromLang] to [toLang].
  /// Pass fromLang as 'Auto Detect' to let the model detect the source language.
  /// Returns only the translated text
  static Future<String> translate({
    required String text,
    required String fromLang,
    required String toLang,
  }) async {
    if (_apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found. Check your .env file.');
    }
    if (text.trim().isEmpty) {
      throw Exception('Please enter text to translate.');
    }

    final sourceInstruction = fromLang == 'Auto Detect'
        ? 'Detect the source language automatically.'
        : 'The source language is $fromLang.';

    final prompt = '''
You are a professional translator. $sourceInstruction
Translate the following text into $toLang.
Rules:
- Output ONLY the translated text.
- Do not add quotes, explanations, notes, or the detected language name.
- Preserve the original tone and meaning as closely as possible.

Text to translate:
"""$text"""
''';


  }
}