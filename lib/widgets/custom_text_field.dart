import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: inputController,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              'images/cloud.png',
              height: 10,
              width: 10,
            ),
          ),
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9ED7FA)),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText: 'Whats in your mind?',
          hintStyle:
              TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.4)),
        ),
      ),
    );
  }
}
