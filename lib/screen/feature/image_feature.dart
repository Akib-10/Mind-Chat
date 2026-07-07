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
  Uint8List? _generatedImage;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _generateImage() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) {
      setState(() => _errorMessage = 'Please enter a prompt first.');
      return;
    }

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
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Creator'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * .02,
          bottom: mq.width * .1,
          left: mq.width * .04,
          right: mq.width * .04,
        ),
        children: [
          // text field
          TextFormField(
            controller: _promptController,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: const InputDecoration(
              hintText:
              'Imagine something wonderful & innovative\nType here & I will create for you',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),

          if (_errorMessage != null) ...[
            SizedBox(height: mq.height * .015),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          // ai image / preview area
          Container(
            height: mq.height * .5,
            alignment: Alignment.center,
            child: _isLoading
                ? Lottie.asset('assets/lottie/ai_play.json', height: mq.height * .3)
                : _generatedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                _generatedImage!,
                fit: BoxFit.contain,
              ),
            )
                : Lottie.asset('assets/lottie/ai_play.json', height: mq.height * .3),
          ),

          // create btn
          CustomBtn(
            text: _isLoading ? 'Creating...' : 'Create',
            onTap: _isLoading ? () {} : _generateImage,
          ),
        ],
      ),
    );
  }
}