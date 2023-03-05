import 'package:flutter/material.dart';

class CustomModifiedAlertDialogue extends StatelessWidget {
  const CustomModifiedAlertDialogue({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    this.actionTitle,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final Function()? action;
  final String? actionTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF7FE).withOpacity(0.0),
      body: Column(
        children: [
          EmptySpace(context: context),
          alertBox(context),
          EmptySpace(context: context),
        ],
      ),
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
              AlertTitleSubtitle(title: title, subtitle: subtitle),
              Container(),
              Container(),
              AlertButton(action: action, actionTitle: actionTitle),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Go Back',
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
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

class CustomGeneralAlertDialogue extends StatelessWidget {
  const CustomGeneralAlertDialogue({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    this.actionTitle,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final Function()? action;
  final String? actionTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF7FE).withOpacity(0.0),
      body: Column(
        children: [
          EmptySpace(context: context),
          alertBox(context),
          EmptySpace(context: context),
        ],
      ),
    );
  }

  Widget alertBox(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          height: 275,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AlertTitleSubtitle(title: title, subtitle: subtitle),
              Container(),
              AlertButton(action: action, actionTitle: actionTitle),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  const AlertButton({
    Key? key,
    required this.action,
    required this.actionTitle,
  }) : super(key: key);

  final Function()? action;
  final String? actionTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              // fontWeight: FontWeight.w600,
              fontSize: 18.5,
              color: Color(0xFF1F1F1F),
            ),
          )),
    );
  }
}

class AlertTitleSubtitle extends StatelessWidget {
  const AlertTitleSubtitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class EmptySpace extends StatelessWidget {
  const EmptySpace({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.white.withOpacity(0.0),
        ),
      ),
    );
  }
}
