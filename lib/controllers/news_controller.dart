import 'package:get/get.dart';
import 'package:lmg_news_app_demo/core/network/network_service.dart';
import 'package:lmg_news_app_demo/models/news_model.dart';

class NewsController extends GetxController {
  var newsArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  NetworkService networkService = NetworkService();

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      var articles = await networkService.fetchNewsArticles();
      newsArticles(articles);
    } catch(e){
      throw Exception(e);
    }
    finally {
      isLoading(false);
    }
  }
}
