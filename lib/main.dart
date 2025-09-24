import 'package:flutter/material.dart';
import 'package:local_notes/listnotifier.dart';
import 'package:provider/provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ListNotifier())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xffe3a365),
            selectionColor: Color(0xffe3a365).withOpacity(0.3),
            selectionHandleColor: Color(0xffe3a365),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
