import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/store/friends.dart';
import 'package:flutter_app_practice_online/widget/add_friend_button.dart';
import 'package:flutter_app_practice_online/widget/edit_friend_button.dart';
import 'package:flutter_app_practice_online/widget/remove_friend_button.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友列表'),
      ),
      body: Consumer<Friends>(builder: (ctx, friends, child) {
        List<Friend> items = friends.items;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) => Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  '${items[index].name}',
                  style: TextStyle(
                      color: items[index].pined ? Colors.red : Colors.grey),
                ),
                trailing: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RemoveFriendButton(
                        index: index,
                      ),
                      EditFriendButton(
                        index: index,
                      )
                    ],
                  ),
                ),
              ),
              Divider()
            ],
          ),
        );
      }),
      floatingActionButton: AddFriendButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
