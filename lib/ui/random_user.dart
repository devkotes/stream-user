// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:stream_user/bloc/random_user_bloc.dart';
import 'package:stream_user/model/random_user_model.dart';

class RandomUser extends StatefulWidget {
  const RandomUser({Key? key}) : super(key: key);

  @override
  State<RandomUser> createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {
  RandomUserBLoC randomUserBLoC = RandomUserBLoC();

  @override
  void dispose() {
    randomUserBLoC.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random User'),
      ),
      body: StreamBuilder(
        stream: randomUserBLoC.randomUserStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting Connection');
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            print('Active Connection');
            if (snapshot.hasError) {
              return Text('There was an error : ${snapshot.error}');
            }
          }

          RandomUserModel user = snapshot.data! as RandomUserModel;
          var name = user.results![0].name;

          return Center(
            child: Text('Nama : ${name!.first}'),
          );
        },
      ),
    );
  }
}
