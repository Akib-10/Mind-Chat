import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          appName,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
          //actions button
        actions: [
          IconButton(
          padding: const EdgeInsets.only(right: 10),
          onPressed: () {},
          icon: const Icon(
            Icons.brightness_4_rounded,
            color: Colors.blue,
            size: 26,
          ))
        ],
      ),
      body: Center(child: Text('Welcome to Home Screen'),)
    );
  }
}
