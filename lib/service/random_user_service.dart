import 'package:http/http.dart' as http;
import 'package:stream_user/model/random_user_model.dart';
import 'dart:convert' as convert;

class RandomUserService {
  static Future<RandomUserModel> browse() async {
    String url = 'https://randomuser.me/api/';
    RandomUserModel? collection;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        collection =
            RandomUserModel.fromJson(convert.jsonDecode(response.body));
        // _contacts =
        //     collection.map((json) => RandomUserModel.fromJson(json)).toList();
      } else {
        // ignore: avoid_print
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e, s) {
      print("Error : $e");
      print("Stack : $s");
      throw Exception('Error gaes');
    }

    return collection!;
  }
}
