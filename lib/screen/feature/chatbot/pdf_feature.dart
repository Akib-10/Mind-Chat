import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'chat_message.dart';
import 'chatbot_service.dart';

class PdfFeature extends StatefulWidget {
  const PdfFeature({super.key});

  @override
  State<PdfFeature> createState() => _PdfFeatureState();
}

class _PdfFeatureState extends State<PdfFeature> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotService _service = ChatbotService();
  final List<ChatMessage> _messages = [];

  //ekbare multiple file (pdf/image) attach rakhar jonno
  final List<File> _attachedFiles = [];

  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //file picker diye pdf/image select korar jonno (multiple allowed)
  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'webp'],
      allowMultiple: true,
    );

    if (result == null) return;

    setState(() {
      for (final f in result.files) {
        if (f.path != null) {
          _attachedFiles.add(File(f.path!));
        }
      }
    });
  }

  void _removeAttachment(int index) {
    setState(() => _attachedFiles.removeAt(index));
  }

  bool _isImageFile(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ext != 'pdf';
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (_isLoading) return;
    //text ba file, dutor moddhe kom pokkhe ekta thakte hobe
    if (text.isEmpty && _attachedFiles.isEmpty) return;

    // attachedFiles ghula filesToSend te copy kore rakha hocche
    // jeno attachedFiles pore clear korle server e send korar jonno filesToSend thake
    final filesToSend = List<File>.from(_attachedFiles);
    // file er nam(/storage/emulated/0/Documents/math.pdf) ber kore anar jonno
    final fileNames = filesToSend.map((f) => f.path.split('/').last).toList();

    // UI update er jonno setState(widget er state change hole)
    setState(() {
      _messages.add(ChatMessage(
        text: text.isEmpty
            ? ' ${fileNames.join(', ')}' //jodi text empty thake tahole shudu file jabe
            : text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true; // typing indicator er jonno
      // UI jeno jante pare je attachedFile update hoiche tai setState er bitor
      _attachedFiles.clear();
    });

    // _controller er jonno TextEditingController ache tai setState lage na
    _controller.clear();
    // UI age update hobe pore Bottom e jabe tai setState er baire
    _scrollToBottom();

    final reply = filesToSend.isEmpty
        ? await _service.sendMessage(text)
        : await _service.analyzeDocuments(files: filesToSend, userText: text);

    // mounted use kori safety er jonno je user ache naki na
    if (!mounted) return;
    setState(() {
      _messages.add(reply);
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) { //age ai draw pore scroll
      if (_scrollController.hasClients) { // listView er sathe jukto na thakle(user nai) scroll kora jabe na
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent, //ekdom nich porjonto jawar jonno
          duration: const Duration(milliseconds: 300), //scrolling duration
          curve: Curves.easeOut, // 1st e fast, end e slow scrolling
        );
      }
    });
  }



  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Reading file(s)...', style: TextStyle(fontSize: 13)),
            SizedBox(width: 8),
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}