import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lmg_news_app_demo/models/news_model.dart';
import 'package:photo_view/photo_view.dart';

class NewsDetailsScreen extends StatelessWidget {
  final List<NewsArticle> articles;
  final int initialIndex;

  const NewsDetailsScreen({super.key, required this.articles, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: articles.length,
            itemBuilder: (context, index, realIndex) {
              final article = articles[index];
              return CachedNetworkImage(
                imageUrl: article.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            },
            options: CarouselOptions(
              initialPage: initialIndex,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(article.imageUrl),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}