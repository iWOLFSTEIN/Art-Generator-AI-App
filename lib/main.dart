import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stem_ai_art_generator/provider/data_provider.dart';
import 'package:stem_ai_art_generator/widgets/custom_alert_dialogue.dart';
import 'package:stem_ai_art_generator/screens/home.dart';
import 'package:stem_ai_art_generator/screens/intro.dart';
import 'package:stem_ai_art_generator/screens/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
        home: const Intro(),
      ),
    );
  }
}
