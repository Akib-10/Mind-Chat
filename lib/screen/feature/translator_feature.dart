import 'package:flutter/material.dart';
import 'package:mind_chat/helper/global.dart';
import 'package:mind_chat/widget/custom_btn.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('Multi Language Translator'),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              top: mq.height * .02,
              bottom: mq.width * .1,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //From Language
              Container(
                height: 50,
                width: mq.width * .4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: Text('From'),
              ),

              //swipe language btn
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.repeat_rounded,
                      color: Colors.grey,
                  )),
              //To Language
              Container(
                height: 50,
                width: mq.width * .4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: Text('To'),
              )
            ],),
            //text field
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.width * .04,
                vertical: mq.height * .035
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                minLines: 5,
                maxLines: null,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),//keyboard hide er jonno
                decoration: const InputDecoration(
                    hintText: 'Translate anything you want......',
                    hintStyle: TextStyle(fontSize: 13.5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )),
              ),
            ),

            //result field
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * .04,
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLines: null,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),//keyboard hide er jonno
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )),
              ),
            ),

            SizedBox(height: mq.height * .04,),

            CustomBtn(text: 'Translate', onTap: (){})
          ],
        )
    );
  }
}
