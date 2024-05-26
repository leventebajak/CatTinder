import 'dart:convert' show jsonDecode;

import 'package:http/http.dart' as http;

/// A service to fetch random cat images from the internet.
class NetworkService {
  /// The base URL of the Cat as a Service API.
  static const _baseURL = "https://cataas.com/cat";

  /// The URL to request a random cat image in JSON format.
  static final _requestURL = Uri.parse("$_baseURL?json=true");

  /// Fetches the id of a random cat image from the internet.
  static Future<String> fetchRandomImageId() async {
    var response = await http.get(_requestURL);
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['_id'] as String;
  }

  /// Makes a URL from the [id] with optional [width] and [height] parameters.
  static String makeUrlFrom(String id, {int? width, int? height}) {
    var url = "$_baseURL/$id";
    if (width != null && height != null) {
      return "$url?width=$width&height=$height";
    } else if (width != null) {
      return "$url?width=$width";
    } else if (height != null) {
      return "$url?height=$height";
    } else {
      return url;
    }
  }
}
