import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool activateSecondaryText = false;
  bool activateTertiaryText = false;
  bool activateAnimation = false;
  int animationId = 0;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFECF7FE),
            body: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 90,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      children: [
                        animatedText(text: 'A robot', setVariable: 1),
                        (!activateSecondaryText)
                            ? Container()
                            : animatedText(
                                text: 'in a cyberpunk city', setVariable: 2),
                        (!activateTertiaryText)
                            ? Container()
                            : animatedText(
                                text: 'doing chores', controller: controller),
                      ],
                    ),
                  ),
                  (animationId == 1)
                      ? imagesBuilder(1, 8)
                      : (animationId == 2)
                          ? imagesBuilder(9, 16)
                          : imagesBuilder(17, 24)
                ])),
          ),
          Container(
            color: Colors.orange,
          ),
        ]);
  }

  Expanded imagesBuilder(int start, int end) {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: activateAnimation ? 1.0 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 9,
            crossAxisSpacing: 9,
            children: [
              for (int i = start; i <= end; i++)
                textResultImage('images/robot/$i.jpg')
            ],
          ),
        ),
      ),
    );
  }

  Padding textResultImage(address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Image.asset(address)),
    );
  }

  AnimatedTextKit animatedText(
      {required String text, int? setVariable, controller}) {
    return AnimatedTextKit(
        isRepeatingAnimation: false,
        pause: const Duration(milliseconds: 0),
        onFinished: (setVariable == null)
            ? () {
                setState(() {
                  animationId++;
                  activateAnimation = true;
                });
                Future.delayed(const Duration(milliseconds: 1500), (() {
                  controller.animateToPage(1,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 1500));
                }));
              }
            : () {
                setState(() {
                  animationId++;
                  activateAnimation = true;
                });
                Future.delayed(const Duration(milliseconds: 1000), (() {
                  if (setVariable == 1) {
                    setState(() {
                      activateSecondaryText = true;
                      activateAnimation = false;
                    });
                  } else if (setVariable == 2) {
                    setState(() {
                      activateTertiaryText = true;
                      activateAnimation = false;
                    });
                  }
                }));
              },
        animatedTexts: [
          TypewriterAnimatedText(
            '',
            speed: const Duration(milliseconds: 50),
            textStyle: const TextStyle(
              fontSize: 22,
            ),
          ),
          TypewriterAnimatedText(
            text,
            cursor: ' ',
            speed: const Duration(milliseconds: 50),
            textStyle: const TextStyle(
              fontSize: 22,
            ),
          ),
        ]);
  }
}
