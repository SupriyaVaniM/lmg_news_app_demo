import 'package:flutter/material.dart';
import 'package:lmg_news_app_demo/views/news_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(NewsController());
    return MaterialApp(
      title: 'LMG NEWS APP DEMO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsPage(),
    );
  }
}
