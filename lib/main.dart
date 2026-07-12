import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mind_chat/helper/global.dart';
import 'package:mind_chat/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'helper/pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //required before any async
  await dotenv.load(fileName: ".env");
  // Init Hive
   Pref.initialize();

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
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.dark,

      darkTheme: ThemeData(
        useMaterial3: false,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blue),
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )
      ),

      //For all pages same AppBar
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        )
      ),

      home: const SplashScreen(),
    );
  }
}
