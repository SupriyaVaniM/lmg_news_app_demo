import 'package:http/http.dart' as http;
import 'package:lmg_news_app_demo/models/news_model.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<NewsArticle>?> fetchNewsArticles() async {
    var apiKey = "IquvD3e9SFb2kaTogFl001wQttegGzGcAR60NaAi";
    var search ="india";
    var publishedAfter = "2023-08-04";

    var response = await client.get(Uri.parse(
        "https://api.thenewsapi.com/v1/news/all?api_token=$apiKey&search=$search&published_after=$publishedAfter"));
    if (response.statusCode == 200) {
      return newsArticleFromJson(response.body);
    } else {
      return null;
    }
  }
}
