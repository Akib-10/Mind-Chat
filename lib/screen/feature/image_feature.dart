import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mind_chat/helper/global.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
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
            right: mq.width * .04
          ),
          children: [
            //text field
          TextFormField(
          textAlign: TextAlign.center,
          minLines: 2,
          maxLines: null,
          onTapOutside: (e) => FocusScope.of(context).unfocus(),//keyboard hide er jonno
          decoration: const InputDecoration(
              hintText: 'Imagine something wonderful & innovative\nType here & I will create for you',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )),
          ),

            //ai image
            Container(
                height: mq.height * .5,
                alignment: Alignment.center,
                child: Lottie.asset('assets/lottie/ai_play.json',
                    height: mq.height * .3))

            //create btn

        ]
        )
    );
  }
}
