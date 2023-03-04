import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stem_ai_art_generator/utils/apis.dart';
import 'package:stem_ai_art_generator/utils/secrets.dart';

// serverLogin() async {
//   var response = await http.post(Uri.parse(serverLoginUrl),
//       body: {'username': username, 'password': password});

//   return json.decode(response.body);
// }

// imagesUrls({required prompt, required token}) async {
// var response = await http.get(Uri.parse(getImagesUrl + prompt), headers: {
//   'Authorization': 'Bearer $token',
// });

//   return json.decode(response.body);
// }

imagesUrls({required prompt}) async {
  var payload = jsonEncode({"prompt": prompt, "n": 2, "size": "512x512"});
  var response = await http.post(Uri.parse(
          // getImagesUrl + prompt
          'https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $key',
      },
      body: payload);

  return json.decode(response.body);
}
