import 'dart:convert';

List<NewsArticle> newsArticleFromJson(String str) => List<NewsArticle>.from(json
    .decode(str)['data']
    .map((x) => NewsArticle.fromJson(Map<String, dynamic>.from(x))));

class NewsArticle {
  final String? uuid;
  final String title;
  final String description;
  final String? keywords;
  final String ?snippet;
  final String? url;
  final String? imageUrl;
  final String? language;
  final DateTime publishedAt;
  final String? source;
  final List<String>? categories;

  NewsArticle({
    this.uuid,
    required this.title,
    required this.description,
     this.keywords,
     this.snippet,
     this.url,
   this.imageUrl,
    this.language,
    required this.publishedAt,
     this.source,
    this.categories,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      uuid: json['uuid'],
      title: json['title'],
      description: json['description'],
      keywords: json['keywords'],
      snippet: json['snippet'],
      url: json['url'],
      imageUrl: json['image_url'],
      language: json['language'],
      publishedAt: DateTime.parse(json['published_at']),
      source: json['source'],
      categories: List<String>.from(json['categories']),
    );
  }
}
