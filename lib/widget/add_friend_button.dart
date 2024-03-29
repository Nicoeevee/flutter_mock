import 'package:flutter/material.dart';
import 'package:flutter_app_practice_online/store/friends.dart';
import 'package:provider/provider.dart';

class AddFriendButton extends StatefulWidget {
  @override
  _AddFriendButtonState createState() => _AddFriendButtonState();
}

class _AddFriendButtonState extends State<AddFriendButton> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Friends>(
      builder: (buildContext, items, child) {
        _addFriend() async {
          final isValid = _formKey.currentState.validate();

          if (!isValid) {
            return;
          }
          final name = _controller.value.text;
          try {
            await items.addFriend(name).whenComplete(() {
              Navigator.pop(context);
              _controller.clear();
            });
          } catch (e) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('添加好友失败，请重试。'),
            ));
          }
        }

        return FloatingActionButton(
          onPressed: () {
            print("add item");
            return showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                context: context,
                builder: (BuildContext buildContext) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.arrow_drop_down),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            autofocus: true,
                            autovalidate: false,
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "输入新好友的昵称"),
                            validator: (name) {
                              if (name.isEmpty) {
                                return '好友昵称不能为空';
                              }
                              bool isExist = items.isFriendExist(name);

                              if (isExist) {
                                return '好友已存在';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                _controller.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                '取消',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            FlatButton(
                              onPressed: _addFriend,
                              child: Text('添加',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        );
      },
    );
  }
}
