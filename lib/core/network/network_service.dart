import 'package:http/http.dart' as http;
import 'package:lmg_news_app_demo/core/constants/constants.dart';
import 'package:lmg_news_app_demo/models/news_model.dart';

class NetworkService {
   var client = http.Client();

   Future<List<NewsArticle>> fetchNewsArticles() async {
    var response = await client.get(Uri.parse(
        "https://api.thenewsapi.com/v1/news/all?api_token=$apiKey&search=$search&published_after=$publishedAfter&categories=$categories"));
    if (response.statusCode == 200) {
      return newsArticleFromJson(response.body);
    } else {
      throw Exception('Failed to load article');
    }
  }
}
