import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stem_ai_art_generator/database/database.dart';
import 'package:stem_ai_art_generator/screens/home.dart';
import 'package:stem_ai_art_generator/widgets/app_branding.dart';
import 'package:stem_ai_art_generator/widgets/custom_text_button.dart';

import '../widgets/custom_slide_fade_transition.dart';
import '../widgets/term_and_services_text_widget.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  bool activateSecondaryText = false;
  bool activateTertiaryText = false;
  bool activateAnimation = false;
  int animationId = 0;

  late final _slideFadeAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  late final _imagesRowAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  final PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _slideFadeAnimationController.dispose();
    _imagesRowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var begin = const Offset(-3.1, 0.0);
    var end = const Offset(2, 0);
    return PageView(
        controller: _pageController,
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
                        animatedTextIntroPage1(text: 'A robot', setVariable: 1),
                        (!activateSecondaryText)
                            ? Container()
                            : animatedTextIntroPage1(
                                text: 'in a cyberpunk city', setVariable: 2),
                        (!activateTertiaryText)
                            ? Container()
                            : animatedTextIntroPage1(
                                text: 'doing chores',
                              ),
                      ],
                    ),
                  ),
                  (animationId == 1)
                      ? imagesBuilderIntroPage1(1, 8)
                      : (animationId == 2)
                          ? imagesBuilderIntroPage1(9, 16)
                          : imagesBuilderIntroPage1(17, 24)
                ])),
          ),
          Scaffold(
            backgroundColor: const Color(0xFFECF7FE),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      rowImagesSlideTransitionBuilder(
                          even: false, reverse: true),
                      const SizedBox(
                        height: 10,
                      ),
                      rowImagesSlideTransitionBuilder(
                          even: true, reverse: false)
                    ],
                  ),
                  Container(),
                  CustomSlideFadeTransition(
                      animationController: _slideFadeAnimationController,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15, top: 0),
                        child: AppBranding(showCompanyName: false),
                      )),
                  CustomSlideFadeTransition(
                      animationController: _slideFadeAnimationController,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            richTextSnippet(
                                text: 'Convert ', boldText: 'Ideas'),
                            richTextSnippet(
                                text: 'Into Beautiful ', boldText: 'Images'),
                          ],
                        ),
                      )),
                  CustomSlideFadeTransition(
                      animationController: _slideFadeAnimationController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextButton(
                            buttonHeight: 70,
                            action: () async {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                  (route) => false);
                              await Database().setUserState(newUser: false);
                            },
                            title: 'Get Started',
                            borderRadius: 20,
                            fontSize: 20),
                      )),
                  CustomSlideFadeTransition(
                      animationController: _slideFadeAnimationController,
                      child: const TermsAndServicesTextWidget()),
                  Container(),
                  Container()
                ],
              ),
            ),
          ),
        ]);
  }

  Widget rowImagesSlideTransitionBuilder(
      {required bool even, required bool reverse}) {
    return Transform.rotate(
      angle: -3.14 / 18,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        reverse: reverse,
        child: Row(children: [
          for (var i = 1; i <= 24; i++)
            if (i % 2 == 0 && even)
              rowImagesSlideTransition(
                  begin: const Offset(3.1, 0.0),
                  end: const Offset(-2, 0),
                  index: i)
            else if (i % 2 != 0 && !even)
              rowImagesSlideTransition(
                  begin: const Offset(-3.1, 0.0),
                  end: const Offset(2, 0),
                  index: i)
        ]),
      ),
    );
  }

  SlideTransition rowImagesSlideTransition(
      {required Offset begin, required Offset end, required int index}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: _imagesRowAnimationController,
        curve: Curves.fastOutSlowIn,
      )),
      child: SizedBox(
        height: 150,
        child: textResultImage('images/robot/$index.jpg', paddingRight: 7),
      ),
    );
  }

  RichText richTextSnippet({required text, required boldText}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
            fontSize: 25, color: Colors.black, fontFamily: 'Poppins'),
        children: <TextSpan>[
          TextSpan(
              text: boldText,
              style: const TextStyle(fontSize: 25, color: Color(0xFF3DABF5))),
        ],
      ),
    );
  }

  Expanded imagesBuilderIntroPage1(int start, int end) {
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

  Padding textResultImage(address,
      {double paddingBottom = 0, double paddingRight = 0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom, right: paddingRight),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Image.asset(address)),
    );
  }

  AnimatedTextKit animatedTextIntroPage1(
      {required String text, int? setVariable}) {
    return AnimatedTextKit(
        isRepeatingAnimation: false,
        pause: const Duration(milliseconds: 0),
        onFinished: (setVariable == null)
            ? () {
                setState(() {
                  animationId++;
                  activateAnimation = true;
                });
                navigatorToIntroPage2();
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

  void navigatorToIntroPage2() {
    Future.delayed(const Duration(milliseconds: 1000), (() {
      _pageController
          .animateToPage(1,
              curve: Curves.ease, duration: const Duration(milliseconds: 1000))
          .whenComplete(
        () {
          _imagesRowAnimationController.forward();
          _slideFadeAnimationController.forward();
        },
      );
    }));
  }
}
