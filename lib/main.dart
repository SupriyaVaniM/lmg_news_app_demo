import 'package:flutter/material.dart';
import 'package:lmg_news_app_demo/views/news_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool launch = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMG NEWS APP DEMO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (ctx, timer) => timer.connectionState == ConnectionState.done
              ? const NewsPage()
              : Container(
                  color: Colors.white,
                  child: const Image(
                    image: AssetImage('assets/times.png'),
                  ),
                )),
    );
  }
}
