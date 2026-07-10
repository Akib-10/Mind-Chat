import 'dart:convert'; //JSON er jonno
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageGenService {
  // AI model
  static const String _model = 'black-forest-labs/FLUX.1-schnell';
  // API key
  static String get _apiKey => dotenv.env['HF_API_KEY'] ?? '';

  static Uri get _endpoint =>
      Uri.parse('https://router.huggingface.co/hf-inference/models/$_model');

  /// Generates an image from [prompt]. Returns raw image bytes (PNG/JPEG).
  static Future<Uint8List> generateImage(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('HF_API_KEY not found. Check your .env file.');
    }

    final response = await http.post(
      _endpoint,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'inputs': prompt}),
    );

    final contentType = response.headers['content-type'] ?? '';

    // Success: HF returns raw image bytes directly
    if (response.statusCode == 200 && contentType.startsWith('image/')) {
      // image er binary data flutter e pathano hocche
      return response.bodyBytes;
    }

    // Anything else is a JSON error payload
    String message;
    try {
      final data = jsonDecode(response.body);
      if (data is Map && data['error'] != null) {
        // Model cold-start: HF returns estimated_time in seconds
        if (data['estimated_time'] != null) {
          message =
          'Model is warming up, please retry in ~${data['estimated_time'].round()}s.';
        } else {
          message = data['error'].toString();
        }
      } else {
        message = 'Unexpected response (${response.statusCode}).';
      }
    } catch (_) {
      message = 'Request failed (${response.statusCode}): ${response.body}';
    }

    throw Exception(message);
  }
}