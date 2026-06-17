import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mind_chat/helper/global.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Lottie.asset('assets/lottie/ai_ask_me.json',
          height: mq.height * 0.6
          ),

          const Text(
            'Ask Me Anything',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: .5,
            ),
          ),

          SizedBox(
            height: mq.height * .015,
          ),

          SizedBox(
            width: mq.width * .7,
            child: const Text(
              'I can be your best friend & You can ask me anything & I will help you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                letterSpacing: .5,
                color: Colors.black87,
              ),
            ),
          ),
          const Spacer(),
          // for dots
          Wrap( // children ke row er moto sajay
            spacing: 10, // child er maje gap deoyar jonno
            children: List.generate(
                3,
                (i) => Container(
                  width: 10,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                )
            ),
          ),
          const Spacer(),
          //for button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 0,
                backgroundColor: Colors.blueAccent,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                minimumSize: Size(mq.width * .4, 50),
              ),
              onPressed: () {} , child: Text('Next')),
          const Spacer(),
        ],
      )
    );
  }
}
