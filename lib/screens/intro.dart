import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stem_ai_art_generator/screens/home.dart';
import 'package:stem_ai_art_generator/widgets/app_branding.dart';
import 'package:stem_ai_art_generator/widgets/custom_text_button.dart';

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

  late final _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  late final _animationControllerRow = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  final PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        animatedText(text: 'A robot', setVariable: 1),
                        (!activateSecondaryText)
                            ? Container()
                            : animatedText(
                                text: 'in a cyberpunk city', setVariable: 2),
                        (!activateTertiaryText)
                            ? Container()
                            : animatedText(
                                text: 'doing chores',
                              ),
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
          Scaffold(
            backgroundColor: const Color(0xFFECF7FE),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Transform.rotate(
                        angle: -3.14 / 18,
                        child: SingleChildScrollView(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          child: Row(
                            children: [
                              for (var i = 1; i <= 24; i++)
                                if (i % 2 != 0)
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-3.1, 0.0),
                                      end: const Offset(2, 0),
                                    ).animate(CurvedAnimation(
                                      parent: _animationControllerRow,
                                      curve: Curves.fastOutSlowIn,
                                    )),
                                    child: SizedBox(
                                      height: 150,
                                      child: textResultImage(
                                          'images/robot/$i.jpg',
                                          paddingRight: 7),
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Transform.rotate(
                        angle: -3.14 / 18,
                        child: SingleChildScrollView(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          child: Row(
                            children: [
                              for (var i = 1; i <= 24; i++)
                                if (i % 2 == 0)
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(3.1, 0.0),
                                      end: const Offset(-2, 0),
                                    ).animate(CurvedAnimation(
                                      parent: _animationControllerRow,
                                      curve: Curves.fastOutSlowIn,
                                    )),
                                    child: SizedBox(
                                      height: 150,
                                      child: textResultImage(
                                          'images/robot/$i.jpg',
                                          paddingRight: 7),
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(),
                  customSlideFadeTransition(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15, top: 0),
                      child: AppBranding(showCompanyName: false),
                    ),
                  ),
                  customSlideFadeTransition(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richTextSnippet(text: 'Convert ', boldText: 'Ideas'),
                          richTextSnippet(
                              text: 'Into Beautiful ', boldText: 'Images'),
                        ],
                      ),
                    ),
                  ),
                  customSlideFadeTransition(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextButton(
                          buttonHeight: 70,
                          action: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const Home()));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (route) => false);
                          },
                          title: 'Get Started',
                          borderRadius: 20,
                          fontSize: 20),
                    ),
                  ),
                  customSlideFadeTransition(
                      child: const TermsAndServicesTextWidget()),
                  Container(),
                  Container()
                ],
              ),
            ),
          ),
        ]);
  }

  Widget customSlideFadeTransition({required Widget child}) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.4),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.fastOutSlowIn,
        )),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastOutSlowIn,
          ),
          child: child,
        ));
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Color(0xFF3DABF5))),
        ],
      ),
    );
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

  Padding textResultImage(address,
      {double paddingBottom = 0, double paddingRight = 0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom, right: paddingRight),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Image.asset(address)),
    );
  }

  AnimatedTextKit animatedText({required String text, int? setVariable}) {
    return AnimatedTextKit(
        isRepeatingAnimation: false,
        pause: const Duration(milliseconds: 0),
        onFinished: (setVariable == null)
            ? () {
                setState(() {
                  animationId++;
                  activateAnimation = true;
                });
                Future.delayed(const Duration(milliseconds: 1000), (() {
                  _pageController
                      .animateToPage(1,
                          curve: Curves.fastOutSlowIn,
                          duration: const Duration(milliseconds: 1000))
                      .whenComplete(
                    () {
                      _animationControllerRow.forward();
                      _animationController.forward();
                    },
                  );
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
