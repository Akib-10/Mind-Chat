import 'package:flutter/material.dart';
import 'package:mind_chat/screen/home_screen.dart';
import 'package:mind_chat/widget/custom_loading.dart';

import '../helper/global.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //wait for some time on Splash & then move to next screen
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    //Initialize Device Size
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Spacer(), //space create korar jonno

            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(padding: EdgeInsets.all(mq.width * .05),
                child: Image.asset('assets/images/logo.png',width: mq.width * .4,),
              ),
            ),
            Spacer(),
            CustomLoading(),
            Spacer(),
          ],
        ),
      )
    );
  }
}
