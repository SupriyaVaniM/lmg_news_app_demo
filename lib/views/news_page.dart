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
          title: const Text("Top News"),
        ),
        body: Obx(
          () => newsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                //These two properties are by default enabled, so in our case..
                // we can simply disable them so that the children which are not visible will be disposed and garbage collected automatically.
                //This could lead to use more GPU and CPU work because of repainting the children and also managing the state, 
                //but it could solve our memory issue and you get a very performant view without noticeable issues.
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: newsController.newsArticles.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpandedView(
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