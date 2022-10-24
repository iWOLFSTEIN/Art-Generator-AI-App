import 'package:flutter/material.dart';

class CustomAlertDialogue extends StatelessWidget {
  const CustomAlertDialogue(
      {Key? key, this.title, this.subtitle, this.action, this.actionTitle})
      : super(key: key);
  final String? title;
  final String? subtitle;
  final Function()? action;
  final String? actionTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF7FE).withOpacity(0.0),
      body: alertBox(context),
    );
  }

  Widget alertBox(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          height: 325,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1F1F1F),
                        fontWeight: FontWeight.w600,
                        height: 1.1),
                  ),
                  const SizedBox(
                    height: 12.5,
                  ),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ],
              ),
              Container(),
              Container(),
              Container(
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF9ED5FA),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextButton(
                    onPressed: action,
                    child: Text(
                      actionTitle!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.5,
                        color: Color(0xFF1F1F1F),
                      ),
                    )),
              ),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Go Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.5,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
