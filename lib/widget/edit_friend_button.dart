import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/store/friends.dart';
import 'package:provider/provider.dart';

class EditFriendButton extends StatefulWidget {
  final index;

  const EditFriendButton({Key key, this.index}) : super(key: key);

  @override
  _EditFriendButtonState createState() => _EditFriendButtonState();
}

class _EditFriendButtonState extends State<EditFriendButton> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Friends>(builder: (context, friends, child) {
      final index = widget.index;
      final Friend item = friends.items[index];
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          var pined = await showEditDialog(context, friends.items[index]);
          if (pined == null) {
            print('取消修改');
          } else {
            final isValid = _formKey.currentState.validate();

            if (!isValid) {
              return;
            }

            try {
              await friends.editFriend(
                index,
                item.name,
                pined,
              );
            } catch (e) {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('修改好友失败了，请重试。')),
              );
            }
            print('置顶状态改变');
          }
        },
      );
    });
  }

  Future<bool> showEditDialog(BuildContext context, Friend item) {
    bool _isChecked = item.pined;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('修改好友'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: false,
                  autovalidate: false,
                  initialValue: item.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: '输入好友昵称'),
                  onChanged: (val) {
                    item.name = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return '好友昵称不能为空';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("同时置顶好友？"),
                  // 通过Builder来获得构建Checkbox的`context`，
                  // 这是一种常用的缩小`context`范围的方式
                  Builder(builder: (BuildContext context) {
                    return Checkbox(
                      value: _isChecked,
                      onChanged: (bool b) {
                        (context as Element).markNeedsBuild();
                        _isChecked = !_isChecked;
                      },
                    );
                  })
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('修改'),
              onPressed: () {
                final isValid = _formKey.currentState.validate();
                if (!isValid) {
                  return;
                }
                Navigator.of(context).pop(_isChecked);
              },
            ),
          ],
        );
      },
    );
  }
}
