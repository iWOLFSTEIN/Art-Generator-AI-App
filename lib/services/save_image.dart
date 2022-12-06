import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../utils/app_directory.dart';

// saveNetworkImage(url) async {
//   return GallerySaver.saveImage(url).then((value) {
//     return value;
//   });
// }

saveGalleryImage(image) async {
  // if (image != null) {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final imagePath = await File('${directory.path}/image.png').create();
  //   await imagePath.writeAsBytes(image);
  // }
  // return true;

  // GallerySaver.saveImage(image.path).then((value) {
  //   return value;
  // });
  var fileName = DateTime.now().microsecondsSinceEpoch;
  var directory = await getAppDirectory() + '/$fileName.png';
  final file = File(directory);
  await file.writeAsBytes(image).then((value) {
    if (value.path.isNotEmpty) {
      return true;
    }
  });
}
