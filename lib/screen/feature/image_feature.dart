import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mind_chat/helper/global.dart';
import 'package:mind_chat/screen/feature/image_gen_service.dart';


import '../../widget/custom_btn.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final TextEditingController _promptController = TextEditingController();
  // AI theke asha Image store korte
  Uint8List? _generatedImage;
  bool _isLoading = false;
  // API error hole message thakar jonno
  String? _errorMessage;

  Future<void> _generateImage() async {
    // trim use kori 1st and last space remove korar jonno
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) {
      setState(() => _errorMessage = 'Please enter a prompt first.');
      return;
    }

    // keyboard hide korar jonno, jeno image create hole keyboard cole jay
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final bytes = await ImageGenService.generateImage(prompt);
      setState(() => _generatedImage = bytes);
    } catch (e) {
      setState(() => _errorMessage = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    //memory jeno leak na hoy
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}