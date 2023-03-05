import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/app_directory.dart';

saveGalleryImage(image, url) async {
  // var directory = '${await getDownloadPath()}/${imageName(url)}';
  var directory = '${await getAppDirectory()}/${imageName(url)}';
  final file = File(directory);
  await file.writeAsBytes(image).then((value) {
    if (value.path.isNotEmpty) {
      return true;
    }
  });
}

String imageName(url) {
  final dateTime = DateTime.now();

  String name =
      'IMG-${dateTime.millisecondsSinceEpoch}-SA${dateTime.hour}${dateTime.minute}.png';
  return name;
}

// Future<void> saveNetworkImageToDisk(String url) async {
//   var response = await http.get(Uri.parse(url));
//   final File file = File('${await getDownloadPath()}/${imageName(url)}');
//   return file.writeAsBytesSync(response.bodyBytes);
// }
