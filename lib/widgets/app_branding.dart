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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Opacity(
                  opacity: 1.0,
                  child: ImageIcon(
                    AssetImage('images/LOGO2.png'),
                    size: 23,
                    color: Color(0xFF1F1F1F),
                  )
                  //  Image.asset(
                  //   'images/technology.png',
                  //   height: 25,
                  //   width: 25,
                  // ),
                  ),
              SizedBox(
                width: 7.5,
              ),
              Text(
                'stem ai',
                style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 24,
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
