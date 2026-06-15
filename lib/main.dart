import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_chat/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Flutter api use korar age framework initialize hoise naki dekhte
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //full screen mode e calay
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  //screen always jeno soja thake
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen() ,
    );
  }
}
