import 'package:get/get.dart';
import 'package:lmg_news_app_demo/core/network/network_service.dart';
import 'package:lmg_news_app_demo/models/news_model.dart';



class NewsController extends GetxController {
  final NetworkService _networkService = NetworkService();
  RxList<NewsArticle> newsArticles = <NewsArticle>[].obs;

  Future<void> fetchNews() async {
    try {
      final responseData = await _networkService.fetchNews(
        'IquvD3e9SFb2kaTogFl001wQttegGzGcAR60NaAi',
        'india',
        'tech',
        'en',
        '2023-08-04',
      );
      newsArticles.assignAll(responseData);
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching news: $error');
    
    }
  }
}