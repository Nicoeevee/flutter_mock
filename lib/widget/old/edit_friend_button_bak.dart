//import 'package:flutter/material.dart';
//import 'package:flutter_app_practice_online/store/friends.dart';
//import 'package:provider/provider.dart';
//
//class EditFriendButton extends StatefulWidget {
//  final index;
//
//  const EditFriendButton({Key key, this.index}) : super(key: key);
//
//  @override
//  _EditFriendButtonState createState() => _EditFriendButtonState();
//}
//
//class _EditFriendButtonState extends State<EditFriendButton> {
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  void dispose() {
//    _formKey?.currentState?.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Consumer<Friends>(builder: (context, friends, child) {
//      final index = widget.index;
//      return IconButton(
//        icon: Icon(Icons.edit),
//        onPressed: () async {
//          var pined = await showEditDialog(context, friends.items[index]);
//          if (pined == null) {
//            print('取消修改');
//          } else {
//            friends.togglePinTo(index, pined);
//            print('置顶状态改变');
//          }
//        },
//      );
//    });
//  }
//
//  Future<bool> showEditDialog(BuildContext context, Friend item) {
//    bool _isChecked = item.pined;
//    return showDialog<bool>(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text('修改好友'),
//          content: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Form(
//                key: _formKey,
//                child: TextFormField(
//                  autofocus: false,
//                  autovalidate: false,
//                  initialValue: item.name,
//                  decoration: InputDecoration(
//                      border: OutlineInputBorder(), labelText: '输入好友昵称'),
//                  onChanged: (val) {
//                    item.name = val;
//                  },
//                  validator: (val) {
//                    if (val.isEmpty) {
//                      return '好友昵称不能为空';
//                    }
//                    return null;
//                  },
//                ),
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  Text("同时置顶好友？"),
//                  // 通过Builder来获得构建Checkbox的`context`，
//                  // 这是一种常用的缩小`context`范围的方式
//                  Builder(builder: (BuildContext context) {
//                    return Checkbox(
//                      value: _isChecked,
//                      onChanged: (bool b) {
//                        (context as Element).markNeedsBuild();
//                        _isChecked = !_isChecked;
//                      },
//                    );
//                  })
//                ],
//              )
//            ],
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('取消'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            FlatButton(
//              child: Text('修改'),
//              onPressed: () {
//                final isValid = _formKey.currentState.validate();
//                if (!isValid) {
//                  return;
//                }
//                Navigator.of(context).pop(_isChecked);
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
////  Future buildShowDialog(
////      BuildContext context, Friend item, Friends friends, index) {
////    return showDialog(
////        context: context,
////        builder: (BuildContext context) {
////          return SimpleDialog(
////            title: Text('编辑好友'),
////            contentPadding: const EdgeInsets.all(24.0),
////            children: <Widget>[
////              Form(
////                key: _formKey,
////                child: Column(
////                  children: <Widget>[
////                    TextFormField(
////                      autofocus: false,
////                      autovalidate: false,
////                      initialValue: item.name,
////                      decoration: InputDecoration(
////                          border: OutlineInputBorder(), labelText: '输入好友昵称'),
////                      onChanged: (val) {
////                        (context as Element).markNeedsBuild();
////                        item.name = val;
////                      },
////                      validator: (val) {
////                        if (val.isEmpty) {
////                          return '好友昵称不能为空';
////                        }
////                        return null;
////                      },
////                    ),
////                    SizedBox(),
////                    SwitchListTile(
////                      value: item.pined,
////                      onChanged: (bool val) {
////                        item.pined = val;
////                      },
////                      title: const Text('是否置顶'),
////                    ),
////                    SizedBox(),
////                    Row(
////                      mainAxisAlignment: MainAxisAlignment.end,
////                      children: <Widget>[
////                        FlatButton(
////                            onPressed: () => Navigator.pop(context),
////                            child: Text('取消')),
////                        FlatButton(
////                            onPressed: () {
////                              final isValid = _formKey.currentState.validate();
////
////                              if (!isValid) {
////                                return;
////                              }
////
////                              Navigator.pop(context);
////
////                              friends.editFriend(index, item.name, item.pined);
////                            },
////                            child: Text('修改'))
////                      ],
////                    )
////                  ],
////                ),
////              )
////            ],
////          );
////        });
////  }
//
//}
