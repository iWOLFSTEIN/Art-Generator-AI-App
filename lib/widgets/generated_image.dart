import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GeneratedImage extends StatefulWidget {
  const GeneratedImage({
    super.key,
    required this.imageAdress,
  });

  final String imageAdress;

  @override
  State<GeneratedImage> createState() => _GeneratedImageState();
}

class _GeneratedImageState extends State<GeneratedImage> {
  double containerHeight = 0;
  final GlobalKey _cachedNetworkImageKey = GlobalKey();
  final GlobalKey _assetImageKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWidgetInfo();
  }

  _getWidgetInfo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        double? postRenderedHeight;
        try {
          postRenderedHeight =
              _cachedNetworkImageKey.currentContext!.size!.height;

          if (_assetImageKey.currentWidget == null) {
            setState(() {
              containerHeight = postRenderedHeight!;
            });
            timer.cancel();
          } else {
            setState(() {
              containerHeight = postRenderedHeight!;
            });
          }
        } catch (e) {
          // print(e.toString());
        }
        // print(containerHeight);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Stack(
            children: [
              // Stack(
              //   children: [
              // FadeInImage.assetNetwork(
              //     key: _cachedNetworkImageKey,
              //     placeholder: 'images/placeholder.png',
              //     image: widget.imageAdress),
              CachedNetworkImage(
                key: _cachedNetworkImageKey,
                imageUrl: widget.imageAdress,
                fadeOutDuration: const Duration(milliseconds: 300),
                fadeOutCurve: Curves.easeOut,
                fadeInDuration: const Duration(milliseconds: 700),
                fadeInCurve: Curves.easeIn,
                placeholder: (context, url) => Image.asset(
                  'images/placeholder.png',
                  key: _assetImageKey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

              // Container(
              //   height: imageProvider.maxHeight?.toDouble(),
              //   width: imageProvider.maxWidth?.toDouble(),
              //   decoration:
              //       BoxDecoration(image: DecorationImage(image: imageProvider)),
              // ),
              //     Container(
              //       height: containerHeight,
              //       color: Colors.black.withOpacity(0.3),
              //     )
              //   ],
              // ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.ease,
                height: containerHeight,
                width: double.infinity,
                // color: Colors.black.withOpacity(0.3),
                alignment: Alignment.bottomLeft,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: Center(
                      child: Text(
                        'An image is placed here so that the user can see it',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontSize: 12, height: 1),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
