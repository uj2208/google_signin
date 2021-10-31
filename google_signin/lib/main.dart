import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_signin/provider/bottom_Nav_Provider.dart';
import 'package:google_signin/provider/phone_verify_provider.dart';
import 'package:provider/provider.dart';
import 'provider/google_sign_in.dart';
import 'screens/homepage.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider(),),
        ChangeNotifierProvider(create: (context) => PhoneProvider(),),
        ChangeNotifierProvider(create: (context)=>BottomProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: HomePage()
      ),
    );
  }
}


