import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_news_app_demo/controllers/news_controller.dart';
import 'package:lmg_news_app_demo/views/expanded_news_page.dart';
import 'package:lmg_news_app_demo/widgets/headlines_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 243, 252),
        appBar: AppBar(
          title: Text("Top News"),
        ),
        body: Obx(
          () => newsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: newsController.newsArticles.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    title: newsController
                                        .newsArticles[index].title,
                                    description: newsController
                                        .newsArticles[index].description,
                                    imageUrl: newsController
                                            .newsArticles[index].imageUrl ??
                                        "",
                                   
                                    publishedAt: newsController
                                        .newsArticles[index].publishedAt
                                        .toString(),
                                 
                                  ))),
                      child: NewsCard(
                          title: newsController.newsArticles[index].title,
                          description:
                              newsController.newsArticles[index].description,
                          imageUrl:
                              newsController.newsArticles[index].imageUrl ??
                                  "",
                        
                          publishedAt: newsController
                              .newsArticles[index].publishedAt
                              .toString())),
                ),
        ));
  }
}