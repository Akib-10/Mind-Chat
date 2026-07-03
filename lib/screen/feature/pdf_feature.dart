import 'package:flutter/material.dart';

class PdfFeature extends StatefulWidget {
  const PdfFeature({super.key});

  @override
  State<PdfFeature> createState() => _PdfFeatureState();
}

class _PdfFeatureState extends State<PdfFeature> {

  //text field control korar jonno TextEditingController
  final TextEditingController _controller = TextEditingController();
  // text field scroll korte
  final ScrollController _scrollController = ScrollController();
  final ChatbotService _service = ChatbotService();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear chat',
            onPressed: () {
              setState(() => _messages.clear());
              _service.clearChat();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 100),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                textAlign: TextAlign.left,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                onFieldSubmitted: (_) => _sendMessage(),
                maxLines: null,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Ask me anything you want.....',
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: _isLoading ? Colors.grey : null,
              child: IconButton(
                onPressed: _isLoading ? null : _sendMessage,
                icon: Icon(
                  _isLoading
                      ? Icons.hourglass_top
                      : Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
