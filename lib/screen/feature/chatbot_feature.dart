import 'package:flutter/material.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text('Chat with AI Assistant'),
      ),
      //For adding Chat box
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: [
            //text input field
            Expanded( //khali jaigai text ashar jonno
                child: TextFormField(
                  textAlign: TextAlign.center,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),//keyboard hide er jonno
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Ask me anything you want.....',
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    )
                  ),
            )),
            //for adding some space
            const SizedBox(width: 8,),
            //For send button
            CircleAvatar(
              radius: 24,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.rocket_launch_rounded,
                    color: Colors.white, size: 28
                  ),
              ),
            )
          ]),
      ),


      //body
      body: ListView(
        children: [],
      )
    );
  }
}
