import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:levels222_0/firebase_options.dart';
import 'package:levels222_0/pages/home.dart';
import 'package:levels222_0/user_info.dart';

// MAKE SURE TO BUNDLE FONT
// USE w600, w400,

// need to add local storage in the terms / privacy policy
// Add Firebase delete inactive users to counteract autheticating to check if they exsist,
// Need to handle google error when they hit cancel
// CREATE WEBSITE FOR PRIVACY POLICY AND TERMS SO I CAN REQUEST EMAIL FROM TWITTER

/*
		<key>UISupportedInterfaceOrientations~ipad</key>
		<array>
			<string>UIInterfaceOrientationPortrait</string>
		</array>
*/

// TODO
// --- add the delete method
// --- Ad website so i can get email from X users
// --- Add the google error blocking
// --- fix look (rules and settings)
// --- make sure they need some sort of wifi to play
// --- device test / app attest
// --- add sounds for when ringer is on
// --- tf is SKAdNetwork
// --- make most variables private

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '222 Levels',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        "home": (context) => const Home(),
      },
    );
  }
}
