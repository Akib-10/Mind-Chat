import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mind_chat/helper/global.dart';
import 'package:mind_chat/main.dart';
import 'package:mind_chat/model/onboard.dart';
import 'package:mind_chat/screen/home_screen.dart';
import 'package:mind_chat/widget/custom_btn.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();
    final list = [
      //onboarding 1
      Onboard(
        title: 'Ask Me Anything',
        subtitle:'I can be your best friend & You can ask me anything & I will help you',
        lottie: 'ai_ask_me',
      ),
      //onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        subtitle:'Just Imagine anything & let me know, I will create something wonderful for you!',
        lottie: 'ai_play',
      ),
    ];

    return Scaffold(
      body:PageView.builder( // page horizontally swap korar jonno list view er moto
        controller: c,
          itemCount: list.length, // uporer list er length onujayi page bananor jonno
          itemBuilder: (ctx,ind){
            final isLast = ind == list.length - 1;
            return Column(
              children: [
                Lottie.asset('assets/lottie/${list[ind].lottie}.json',
                    height: mq.height * 0.6,
                  width: isLast ? mq.width * .7 : null, //last tar json choto korar jonno
                ),

                Text(
                  list[ind].title,
                  style: const TextStyle(
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
                  child: Text(
                    list[ind].subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      letterSpacing: .5,
                      color: Theme.of(context).lightTextColor,
                    ),
                  ),
                ),
                const Spacer(),
                // for dots
                Wrap( // children ke row er moto sajay
                  spacing: 10, // child er maje gap deoyar jonno
                  children: List.generate(
                      list.length, // list er page onujayi dot
                          (i) => Container(
                        width: i == ind ? 15 : 10, // je number page oi number er dot 15 size dibe
                        height: 8,
                        decoration: BoxDecoration(
                            color: i==ind ? Colors.blue: Colors.grey,
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                      )
                  ),
                ),
                const Spacer(),
                //for button
                CustomBtn(onTap: () {
                    if(isLast){
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (_) => const HomeScreen()));
                      Get.off( () =>
                        const HomeScreen()
                      );
                    }else{
                        c.nextPage(duration: Duration(milliseconds: 600),
                        curve: Curves.ease);
                    }
                } ,text: isLast ? 'Finish' : 'Next'),
                const Spacer(),
              ],
            );
          })
    );
  }
}
