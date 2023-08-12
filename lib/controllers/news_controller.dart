import 'package:get/get.dart';
import 'package:lmg_news_app_demo/core/network/network_service.dart';
import 'package:lmg_news_app_demo/models/news_model.dart';

class NewsController extends GetxController {
  var newsArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      var articles = await NetworkService.fetchNewsArticles();
      if (articles != null) {
        newsArticles(articles);
      }
    } finally {
      isLoading(false);
    }
  }
}
