import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(
      {Key? key,
      required this.buttonHeight,
      required this.action,
      required this.title,
      required this.fontSize})
      : super(key: key);

  final double buttonHeight;
  final Function() action;
  final String title;
  final double fontSize;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat(period: const Duration(milliseconds: 2000), reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.buttonHeight,
      decoration: const BoxDecoration(
          // color: Color(0xFF06283D),
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: TextButton(
        onPressed: widget.action,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.5),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SlideTransition(
                position: _offsetAnimation,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
