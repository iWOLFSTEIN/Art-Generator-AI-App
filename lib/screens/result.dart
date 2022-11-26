import 'package:alert/alert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stem_ai_art_generator/services/save_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/custom_alert_dialogue.dart';

class Result extends StatefulWidget {
  const Result({Key? key, this.images, this.prompt}) : super(key: key);
  final String? prompt;
  final List? images;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  bool toggleValue = false;
  bool isDownloading = false;
  @override
  Widget build(BuildContext context) {
    List images = [
      for (var image in widget.images!)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF9ED5FA),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child:

                      //  CachedNetworkImage(
                      //   imageUrl: image,
                      //   fit: BoxFit.fill,
                      //   fadeOutDuration: const Duration(milliseconds: 300),
                      //   fadeOutCurve: Curves.easeOut,
                      //   fadeInDuration: const Duration(milliseconds: 700),
                      //   fadeInCurve: Curves.easeIn,
                      //   placeholder: (context, url) => const Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // ),
                      FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: image,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12.5),
                        child: Text(
                          (toggleValue) ? widget.prompt! : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFECF7FE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBar(),
            imagesSlider(images),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  dotIndicator(),
                  const SizedBox(
                    height: 25,
                  ),
                  toggleButton(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      button(
                          title: 'Re-create',
                          icon: Icons.loop,
                          action: () {
                            showAlertDialogue();
                          },
                          color: Colors.white),
                      const SizedBox(
                        width: 15,
                      ),
                      button(
                          title: 'Share',
                          icon: Icons.share_outlined,
                          action: () {},
                          color: const Color(0xFF8BCDF9)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded button(
      {required title, required icon, required color, required action}) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: TextButton(
            onPressed: action,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ),
                const Expanded(child: SizedBox()),
                Icon(
                  icon,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )),
      ),
    );
  }

  AnimatedSmoothIndicator dotIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      duration: const Duration(milliseconds: 500),
      count: 4,
      effect: const SlideEffect(
          dotHeight: 9,
          dotWidth: 9,
          spacing: 11.5,
          dotColor: Color(0xFF9ED5FA),
          activeDotColor: Colors.blue),
    );
  }

  CarouselSlider imagesSlider(List<dynamic> images) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1.2,
          viewportFraction: 0.875,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          }),
      items: images.map((widget) {
        return Builder(
          builder: (BuildContext context) {
            return widget;
          },
        );
      }).toList(),
    );
  }

  Widget toggleButton() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF9ED5FA).withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          const Text(
            'Show Prompt',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Expanded(child: Container()),
          FlutterSwitch(
              toggleSize: 22.5,
              value: toggleValue,
              width: 52.5,
              inactiveColor: const Color(0xFF1F1F1F).withOpacity(0.9),
              onToggle: (value) {
                setState(() {
                  toggleValue = value;
                });
              }),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Padding appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Color(0xFF1F1F1F),
              size: 27.5,
            ),
          ),
          Expanded(child: Container()),
          const Text(
            'Results',
            style: TextStyle(
              color: Color(0xFF1F1F1F),
              fontSize: 18,
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(14.5),
              child: (isDownloading)
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : GestureDetector(
                      onTap: () async {
                        await saveImage();
                      },
                      child: const ImageIcon(
                        AssetImage('images/download.png'),
                        color: Colors.white,
                        size: 22.5,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialogue() {
    var alert = CustomAlertDialogue(
      title: 'Are you sure you want to re-generate the image?',
      subtitle: 'Make sure you saved the image you liked before proceeding.',
      actionTitle: 'Generate Again',
      action: () {},
    );
    showDialog(context: context, builder: (context) => alert);
  }

  saveImage() async {
    setState(() {
      isDownloading = true;
    });
    try {
      var isImageSaved = await saveNetworkImage(widget.images![currentIndex]);
      if (isImageSaved) {
        setState(() {
          isDownloading = false;
        });
        Alert(message: 'Image saved in Gallery').show();
      }
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      print(e.toString());
    }
  }
}
