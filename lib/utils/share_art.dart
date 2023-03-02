import 'package:share_plus/share_plus.dart';

shareImage({required String imageUrl}) async {
  try {
    Share.share(imageUrl);
  } catch (e) {
    print(e.toString());
  }
}
