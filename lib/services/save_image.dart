import 'dart:io';
import '../utils/app_directory.dart';


saveGalleryImage(image) async {
  var fileName = DateTime.now().microsecondsSinceEpoch;
  var directory = await getAppDirectory() + '/$fileName.png';
  final file = File(directory);
  await file.writeAsBytes(image).then((value) {
    if (value.path.isNotEmpty) {
      return true;
    }
  });
}