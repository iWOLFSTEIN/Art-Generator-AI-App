import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stem_ai_art_generator/provider/data_provider.dart';

class InputPrompt extends StatefulWidget {
  const InputPrompt({
    Key? key,
    required this.prompt,
  }) : super(key: key);

  final String prompt;

  @override
  State<InputPrompt> createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt> {
  bool isPromptAnimated = false;

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GestureDetector(
        onTap: () {
          _animatePrompt(dataProvider);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
          decoration: BoxDecoration(
              color: (isPromptAnimated)
                  ? Color(0xFF77C4F8)
                  //  const Color(0xFFFFC2D4)
                  // const Color(0xFFFAF4B7)
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(
            widget.prompt,
            style: TextStyle(
                color: (isPromptAnimated)
                    ? Colors.white
                    : Colors.black.withOpacity(0.4)),
          ),
        ),
      ),
    );
  }

  _animatePrompt(dataProvider) {
    setState(() {
      isPromptAnimated = true;
    });
    dataProvider.prompt = widget.prompt;
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isPromptAnimated = false;
      });
    });
  }
}
