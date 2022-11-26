import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stem_ai_art_generator/screens/result.dart';
import 'package:stem_ai_art_generator/services/api_call.dart';

import '../provider/database_provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, this.prompt}) : super(key: key);

  final String? prompt;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late final _progressBarAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 15000))
    ..addListener(() {
      setState(() {});
    })
    ..forward().then((value) => Navigator.pop(context));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagesResponse();
  }

  List images = [];

  getImagesResponse() async {
    try {
      var databaseProvider =
          Provider.of<DatabaseProvider>(context, listen: false);

      var responseData = await imagesUrls(
          prompt: widget.prompt, token: databaseProvider.jwtToken);

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (responseData != null) {
          print('response is not empty');
          timer.cancel();
          _progressBarAnimationController
              .animateTo(1.0, duration: const Duration(milliseconds: 300))
              .then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Result(
                            prompt: widget.prompt,
                            images: images,
                          ))));
        }
      });

      for (var data in responseData['data']) {
        images.add(data['url']);
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _progressBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8EFFD),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_progressBarAnimationController.value <= 0.20)
              const Text(
                'Analyzing Prompt...',
                style: TextStyle(fontSize: 20.5),
              ),
            if (_progressBarAnimationController.value > 0.20 &&
                _progressBarAnimationController.value <= 0.4)
              const Text(
                'Generating Image...',
                style: TextStyle(fontSize: 20.5),
              ),
            if (_progressBarAnimationController.value > 0.4)
              const Text(
                'Adjusting Colors...',
                style: TextStyle(fontSize: 20.5),
              ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: LinearProgressIndicator(
                  value: _progressBarAnimationController.value,
                  minHeight: 4,
                  backgroundColor: const Color(0xFF9ED5FA),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
