import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/store/friends.dart';
import 'package:provider/provider.dart';

class RemoveFriendButton extends StatelessWidget {
  final int index;

  const RemoveFriendButton({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Friends>(builder: (buildContext, friends, child) {
      return IconButton(
          icon: Icon(Icons.remove),
          onPressed: () async {
            print('按钮：移除好友');
            bool result = await showDeleteDialog(context, friends.items[index]);
            if (result == null) {
              return;
            } else {
              if (result) {
                friends.removeFriend(index);
              }
            }
          });
    });
  }

  Future<bool> showDeleteDialog(BuildContext context, Friend item) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('确认删除 ${item.name} 吗？'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('取消')),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('删除'))
            ],
          );
        });
  }
}
