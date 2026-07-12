import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_chat/model/home_type.dart';
import 'package:mind_chat/widget/home_card.dart';

import '../helper/global.dart';
import '../helper/pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
  }
  @override
  Widget build(BuildContext context) {
    //initializing device size
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text(
          appName,
        ),
          //actions button
        actions: [
          IconButton(
          padding: const EdgeInsets.only(right: 5),
          onPressed: () {},
          icon: const Icon(
            Icons.brightness_4_rounded,
            size: 26,
          ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width *.04,
            vertical: mq.height * .015
        ),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      )
    );
  }
}
