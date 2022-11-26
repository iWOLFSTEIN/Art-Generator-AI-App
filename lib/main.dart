import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stem_ai_art_generator/database/database.dart';
import 'package:stem_ai_art_generator/provider/data_provider.dart';
import 'package:stem_ai_art_generator/provider/database_provider.dart';
import 'package:stem_ai_art_generator/screens/home.dart';
import 'package:stem_ai_art_generator/screens/intro.dart';
import 'package:stem_ai_art_generator/screens/result.dart';
import 'package:stem_ai_art_generator/services/api_call.dart';

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
        ChangeNotifierProvider(create: (context) => Database()),
        ChangeNotifierProxyProvider<Database, DatabaseProvider>(
            create: (context) => DatabaseProvider(Database(), ''),
            update: (context, database, databaseProvider) =>
                DatabaseProvider(database, databaseProvider!.jwtToken)),
      ],
      child: const StartApp(),
    );
  }
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getJwtToken();
  }

  getJwtToken() async {
    var databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    await SharedPreferences.getInstance();

    if (databaseProvider.jwtToken == '') {
      var token = await serverLogin();
      databaseProvider.setJwtToken(value: token['token']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stem AI',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: const Home(),
    );
  }
}
