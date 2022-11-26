import 'package:gallery_saver/gallery_saver.dart';

saveNetworkImage(url) async {
  return GallerySaver.saveImage(url).then((value) {
    return value;
  });
}
