import 'package:flutter/material.dart';

class AppBranding extends StatelessWidget {
  const AppBranding({Key? key, this.showCompanyName = true})
      : super(
          key: key,
        );
  final bool showCompanyName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'images/technology.png',
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(
                width: 7.5,
              ),
              const Text(
                'stem ai',
                style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          (showCompanyName)
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'by clock studio',
                    style: TextStyle(
                      color: const Color(0xFF1F1F1F).withOpacity(0.6),
                      fontSize: 11,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
