import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lmg_news_app_demo/models/news_model.dart';



class NetworkService {
  final String _baseUrl = 'https://api.thenewsapi.com/v1';


  Future<List<NewsArticle>> fetchNews(
    String apiToken,
    String search,
    String categories,
    String language,
    String publishedAfter,
  ) async {
     final url = Uri.parse('$_baseUrl/news/all?api_token=$apiToken&search=$search&categories=$categories&language=$language&published_after=$publishedAfter');

    try {
     final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}