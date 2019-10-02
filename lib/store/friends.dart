import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_practice_online/config/request.dart';

class Friend {
  String id;
  String name;
  bool pined;

  Friend({this.id, this.name, this.pined = false});

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
      id: json["_id"].toString(), name: json["name"], pined: json["pined"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pined": pined,
      };
}

class Friends extends ChangeNotifier {
  List<Friend> _items = [
//    Friend(name: 'Komugi', pined: true),
//    Friend(name: 'Kenny', pined: false),
//    Friend(name: 'Tom', pined: false),
//    Friend(name: 'Whitemane', pined: false),
  ];

  Dio _dio = crateDio();

  get items {
    return [..._items];
  }

  get pinedItems {
    return _items.where((friend) => friend.pined);
  }

  void refresh() {
//    sortPined();
    notifyListeners();
  }

  Future<List> getFriends() async {
    try {
      Response response = await _dio.get('/friends');

      final list = response.data as List;
      _items = List<Friend>.from(list.map((i) => Friend.fromJson(i)).toList());

      return items;
    } on DioError catch (err) {
      throw err;
    }
  }

  Future addFriend(String name) async {
    try {
      Response response = await _dio.post('/friends', data: {
        "name": name,
        "pined": false,
      });
      Friend friend = Friend(
          name: name, id: response.data["_id"], pined: response.data["pined"]);

      _items.insert(0, friend);
      refresh();
    } on DioError catch (err) {
      throw err;
    }
  }

  Future removeFriend(int index) async {
    try {
      String friendId = _items[index].id;
      await _dio.delete("/friends/$friendId");
      _items.removeAt(index);
      refresh();
    } catch (err) {
      throw err;
    }
  }

  Future editFriend(int index, String name, bool pined) async {
    String friendId = _items[index].id;

    try {
      await _dio.put("/friends/$friendId", data: {
        "name": name,
        "pined": pined,
      });

      Friend friend = _items[index];
      friend.name = name;
      friend.pined = pined;
      refresh();
    } catch (err) {
      throw err;
    }
  }

  void sortPined() {
    _items.sort((x, y) => (x.pined == y.pined) ? 0 : (y.pined ? 1 : -1));
  }

//  void addFriend(Friend friend) {
//    _items.insert(0, friend);
//    refresh();
//  }

//  void removeFriend(int index) {
//    _items.removeAt(index);
//    refresh();
//  }
//
//  void editFriend(int index, String name, bool pined) {
//    Friend item = _items[index];
//    item.name = name;
//    item.pined = pined;
//    refresh();
//  }

  void togglePin(int index) {
    final Friend item = _items[index];
    item.pined = !item.pined;
    refresh();
  }

  void togglePinTo(int index, bool pined) {
    final Friend item = _items[index];
    item.pined = pined;
    refresh();
  }

  bool isFriendExist(String name) {
    bool isExist = false;
    for (var i = 0; i < _items.length; ++i) {
      final item = _items[i];
      if (item.name == name) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }
}
