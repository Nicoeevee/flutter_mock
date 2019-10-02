import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/widget/add_friend_button.dart';
import 'package:flutter_app_practice_online/widget/edit_friend_button.dart';
import 'package:flutter_app_practice_online/widget/remove_friend_button.dart';
import 'package:provider/provider.dart';

import 'store/friends.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友列表'),
      ),
      body: FutureBuilder(
          future: Provider.of<Friends>(context).getFriends(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('按下按钮以开始');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: Stack(
                    children: <Widget>[
                      Center(
                          child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 80,
                        height: 80,
                      )),
                      Center(child: Text(('加载中..')))
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text(
                      '出错了，请重试',
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  );
                }

                List<Friend> items = snapshot.data;

                if (items == null) {
                  return Center(
                    child: Text(
                      '还没有朋友，点击“+”添加',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              items[index].name,
                              style: TextStyle(
                                color: items[index].pined
                                    ? Colors.teal
                                    : Colors.grey,
                              ),
                            ),
                            trailing: Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  EditFriendButton(
                                    index: index,
                                  ),
                                  RemoveFriendButton(
                                    index: index,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    });
            }
            return null;
          }),
      floatingActionButton: Consumer<Friends>(
        builder: (context, items, child) {
          return AddFriendButton();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
