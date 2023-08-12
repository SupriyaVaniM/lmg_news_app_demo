import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lmg_news_app_demo/core/mixins/mixin_color.dart';

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

class _ExpandedViewState extends State<ExpandedView> with SingleTickerProviderStateMixin,ConstantColors{
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  final double minScale = 1;
  final double maxScale = 4;
  double scale = 1;
  OverlayEntry? entry;
  @override
  void initState() {
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() => controller.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            title: const Text(
              "NEWS ARTICLE",
              style: TextStyle(
                  color: ConstantColors.redColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  child: const Icon(Icons.chevron_left, color: Colors.white),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.grey,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTitle(),
                  _buildImage(),
                  _buildDate(),
                  _buildDescription()
                ]),
          )),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Builder(
        builder:(context) =>
        InteractiveViewer(
          transformationController: controller,
          clipBehavior: Clip.none,
          panEnabled: false,
          minScale: minScale,
          maxScale: maxScale,
          onInteractionStart: (details) {
            if (details.pointerCount < 2) return;
      
            animationController.stop();
      
            if (entry == null) {
              showOverlay(context);
            }
          },
          onInteractionUpdate: (details) {
            if (entry == null) return;
      
            // ignore: unnecessary_this
            this.scale = details.scale;
            entry!.markNeedsBuild();
          },
          onInteractionEnd: (details) {
            // only executed if interaction ends with no fingers on screen
            if (details.pointerCount != 1) return;
      
            resetAnimation();
          },
          child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
            Text(
              widget.publishedAt,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Expanded(
        flex: 1,
        child: Text(
          widget.description,
          textAlign: TextAlign.center,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );

  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    removeOverlay();

    entry = OverlayEntry(
      builder: (context) {
        final opacity = ((scale - 1) / (maxScale - 1)).clamp(0.0, 1.0);

        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Opacity(
                opacity: opacity,
                child: Container(color: Colors.black),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              width: size.width,
              child: _buildImage(),
            ),
          ],
        );
      },
    );

    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward(from: 0);
  }
}
