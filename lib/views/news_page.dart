import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_news_app_demo/controllers/news_controller.dart';
import 'package:lmg_news_app_demo/views/expanded_news_page.dart';

class NewsScreen extends StatelessWidget {
  final NewsController newsController = Get.find<NewsController>();

 NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: Obx(() {
        if (newsController.newsArticles.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: newsController.newsArticles.length,
            itemBuilder: (context, index) {
              final article = newsController.newsArticles[index];
              return ListTile(
  title: Text(article.title),
  subtitle: Text(article.description),
  leading: Image.network(article.imageUrl),
  onTap: () {
    Get.to(
      () => NewsDetailsScreen(
        articles: newsController.newsArticles,
        initialIndex: index,
      ),
    );
  },
);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newsController.fetchNews();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}