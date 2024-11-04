import 'package:flutter/material.dart';
import 'package:pokedex/pages/home.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFFFFFF0),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color:  Color(0xFF0D0D0D))
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          fillColor: Color(0xFFF2F2F2),
          filled: true,
          contentPadding: EdgeInsets.all(14)
        )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF0D0D0D),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xFF3A3A3A),
              filled: true,
              contentPadding: EdgeInsets.all(14)
          )
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home':(context)=>Home()
      },
    );
  }
}