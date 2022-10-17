import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndServicesTextWidget extends StatelessWidget {
  const TermsAndServicesTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By continuing, you accept our ',
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontFamily: 'Poppins'),
          children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service ',
                style: const TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: Color(0xFF3DABF5)),
                recognizer: TapGestureRecognizer()..onTap = () {}),
            const TextSpan(
              text: 'and acknowledge receipt of our ',
            ),
            TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                    color: Color(0xFF3DABF5)),
                recognizer: TapGestureRecognizer()..onTap = () {}),
          ],
        ),
      ),
    );
  }
}
