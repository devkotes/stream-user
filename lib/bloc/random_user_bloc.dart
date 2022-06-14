import 'dart:async';

import 'package:stream_user/model/random_user_model.dart';
import 'package:stream_user/service/random_user_service.dart';

class RandomUserBLoC {
  Stream<RandomUserModel> get randomUser async* {
    yield* Stream.periodic(Duration(seconds: 2))
        .asyncMap((event) => RandomUserService.browse());

    // yield await RandomUserService.browse();
  }

  final StreamController<RandomUserModel> _randomController =
      StreamController<RandomUserModel>();

  Stream<RandomUserModel> get randomUserStream => _randomController.stream;

  RandomUserBLoC() {
    randomUser.listen((event) {
      if (!_randomController.isClosed) {
        print("Datas : ${event.toJson()}");
        _randomController.add(event);
      }
    });
  }

  Future<void> closeStream() async {
    _randomController.close();
  }
}
