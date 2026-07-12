import 'package:flutter/material.dart';
import 'package:mind_chat/main.dart';

import '../helper/global.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 2, // shadow remove kore
            backgroundColor: Theme.of(context).buttonColor,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            minimumSize: Size(mq.width * .4, 50),
          ),
          onPressed: onTap,
          child: Text(text)),
    );

  }
}
