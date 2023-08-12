import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExpandedView extends StatefulWidget {
  final String title;
  final String description;
  final String publishedAt;

  final String imageUrl;

  const ExpandedView({
    super.key,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.imageUrl,
  });

  @override
  State<ExpandedView> createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
    
        ),
        backgroundColor: Colors.grey[200],
        body: Stack(
          children:[
            Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  widget.imageUrl,
                                  errorListener: () {
                                    const Text(
                                      'Loading',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    );
                                  },
                                ))),),
                                 Padding(
                                   padding: const EdgeInsets.only(top:10.0),
                                   child: Align(
                                     alignment: Alignment.topCenter,
                                     child: Text(
                                                           widget.title,
                                                           maxLines: 1,
                                                           overflow: TextOverflow.ellipsis,
                                                           style: const TextStyle(
                                                               color: Colors.white,
                                                               fontSize: 20,
                                                               fontWeight: FontWeight.w600),
                                                         ),
                                   ),
                                 ),
          ] 
        )),
    );
     
          
        
      
    
  }
}
