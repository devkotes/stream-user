import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:stream_user/model/user_model.dart';

class UserService {
  static Future<List<User>> browse() async {
    String url = 'https://jsonplaceholder.typicode.com/users';
    List collection;
    List<User>? _contacts;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      _contacts = collection.map((json) => User.fromJson(json)).toList();
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }

    return _contacts!;
  }
}
