import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(.2),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        children:[
          //Lottie
          Lottie.asset('assets/lottie/ai_hand_waving.json',
                width: mq.width*.35
          ),
          const Spacer(),
          //title
          const Text(
            'AI ChatBot',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            )
          ),
          const Spacer(flex: 2,),
        ]
      ),
    );
  }
}
