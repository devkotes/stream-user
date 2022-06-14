import 'package:flutter/material.dart';
import 'package:stream_user/bloc/user_bloc.dart';
import 'package:stream_user/model/user_model.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  UserBLoC userBLoC = UserBLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          Chip(
            label: StreamBuilder<int>(
                stream: userBLoC.userCounter,
                builder: (context, snapshot) {
                  return Text(
                    (snapshot.data ?? 0).toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }),
            backgroundColor: Colors.red,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
          )
        ],
      ),
      body: StreamBuilder(
        stream: userBLoC.usersList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('There was an error : ${snapshot.error}');
              }

              List<User> users = snapshot.data as List<User>;

              return ListView.separated(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  User _user = users[index];
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      title: Text(_user.name),
                      subtitle: Text(_user.email),
                      leading: CircleAvatar(
                        child: Text(_user.symbol),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
          }
        },
      ),
    );
  }
}
