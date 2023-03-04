import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:stem_ai_art_generator/services/save_image.dart';

void main() async {
  await savedImage();
}

Future<void> savedImage() async {
  return test('file is sound', () async {
    String url =
        'https://oaidalleapiprodscus.blob.core.windows.net/private/org-Idd6RzQrPukDm6frO4cNeiif/user-qL9hczKZgJM2OGn32p0xr7Km/img-Z4MbTUR3qf8Z5BlXLcjj0lOb.png?st=2023-03-04T03%3A25%3A30Z&se=2023-03-04T05%3A25%3A30Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-03-03T19%3A31%3A25Z&ske=2023-03-04T19%3A31%3A25Z&sks=b&skv=2021-08-06&sig=Wrw3a5%2B%2Bz0D5oRet%2B/fQJkKqva8MVv95wZ7J2V4czrg%3D';
    await saveNetworkImageToDisk(url);
    expect(
        Directory(
                '/storage/emulated/0/Download/img-Z4MbTUR3qf8Z5BlXLcjj0lOb.png')
            .path,
        '/storage/emulated/0/Download/img-Z4MbTUR3qf8Z5BlXLcjj0lOb.png');
  });
}
