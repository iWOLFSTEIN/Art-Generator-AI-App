import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  bool toggleValue = false;
  @override
  Widget build(BuildContext context) {
    List images = [
      for (var i = 0; i < 4; i++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF9ED5FA),
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          action: (){},
                          color: Colors.white),
                      const SizedBox(
                        width: 15,
                      ),
                      button(
                          title: 'Share',
                          icon: Icons.share_outlined,
                          action: (){},
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

  Expanded button({required title, required icon, required color, required action}) {
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
          const Icon(
            Icons.close,
            color: Color(0xFF1F1F1F),
            size: 27.5,
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
            child: const Padding(
              padding: EdgeInsets.all(14.5),
              child: ImageIcon(
                AssetImage('images/download.png'),
                color: Colors.white,
                size: 22.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
