import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String publishedAt;
  final String? author;
  final String imageUrl;
  const NewsCard(
      {super.key,
      required this.title,
      this.author,
      required this.description,
      required this.imageUrl,
      required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Column(
              children: [
               _buildTitle(),
                _buildDescription(),
               _buildSizedBox(),
              _buildCalender()
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTitle(){
    return  Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                );
  }
   Widget _buildDescription(){
    return Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                );
   }
   Widget _buildSizedBox(){
    return  const SizedBox(
                  height: 10,
                );
   }
   Widget _buildCalender(){
    return   Row(
                  children: [
                    const Icon(
                      Icons.person_rounded,
                      color: Colors.black26,
                    ),
                    Text(
                      publishedAt,
                      style: const TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ],
                );
   }
   Widget _buildImage(){
    return Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      imageUrl,
                      errorListener: () {
                        const Text(
                          'Loading',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  )));
   }
}
