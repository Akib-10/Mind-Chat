import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'chatbot_service.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  //text field control korar jonno TextEditingController
  final TextEditingController _controller = TextEditingController();
  // text field scroll korte
  final ScrollController _scrollController = ScrollController();
  final ChatbotService _service = ChatbotService();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void dispose() {
    //memory free korar jonno dispose
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      //service e pathanor sathe sathe jeno bubble text ashe
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    // ✅ FIXED: sendMessage now returns ChatMessage directly
    final reply = await _service.sendMessage(text);

    setState(() {
      _messages.add(reply);
      _isLoading = false;
    });

    _scrollToBottom();
  }

  //new msg ashar por listview ke niche scroll kore rakhar jonno
  void _scrollToBottom() {
    // UI update er por scroll korar jonno
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // clients ache naki check korte
      if (_scrollController.hasClients) {
        // dhire dhire scroll korar jonno
        _scrollController.animateTo(
          //scroll kore sob theke niche jawar jonno
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          // 1st e fast scroll pore slow scroll
          curve: Curves.easeOut,
        );
      }
    });
  }

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

  // app er 1st er UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'Ask me anything!',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          ),
        ],
      ),
    );
  }

  //bubble msg er jonno
  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser; //message.isUser na likhe isUser likhar jonno
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
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
            _DotPulse(delay: 0),
            SizedBox(width: 4),
            _DotPulse(delay: 150),
            SizedBox(width: 4),
            _DotPulse(delay: 300),
          ],
        ),
      ),
    );
  }
}

// Dots(.....) animation er jonno
class _DotPulse extends StatefulWidget {
  final int delay;
  const _DotPulse({required this.delay});

  @override
  State<_DotPulse> createState() => _DotPulseState();
}

class _DotPulseState extends State<_DotPulse>
    with SingleTickerProviderStateMixin { //animation control er jonno
  // animation control korar jonno
  late AnimationController _ctrl;
  // animation er value
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      //Screen Visible na hole animation pause korar jonno
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      // user screen e ache naki janar jonno mounted use kori
      if (mounted) _ctrl.repeat(reverse: true);
    });
    // bots 1st e halka pore aste aste full dekhar jonno
    _anim = Tween(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() { //AnimationController Memory theke remove korar jonno
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
    );
  }
}