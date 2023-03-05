import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stem_ai_art_generator/utils/permissions_manager.dart';

import '../services/save_image.dart';

shareImage(Uint8List imageBytes, String imageUrl) async {
  try {
    File file = await saveTempImage(imageBytes, imageUrl);
    Share.shareFiles([file.path]).whenComplete(() {
      file.delete();
    });
  } catch (e) {}
}

saveTempImage(Uint8List imageBytes, String url) async {
  var tempDir = await getTemporaryDirectory();
  var path = '${tempDir.path}/${imageName(url)}';
  final file = File(path);
  return await file.writeAsBytes(imageBytes).then((value) {
    if (value.path.isNotEmpty) {
      return value;
    }
  });
}
