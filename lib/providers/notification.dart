import 'dart:async';

import 'package:F4Lab/ui/logic_widget/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration DEFAULT = Duration(seconds: 3);

class NotificationItem {
  static int count = 0;

  final Type type;
  final String content;
  final StreamController<NotificationItem> _streamController;
  var dismiss = false;
  var id;

  NotificationItem(this.type, this.content, this._streamController) {
    count++;
    id = count;
    if (type != Type.LOADING) {
      Future.delayed(DEFAULT, () {
        dismiss = true;
        _streamController.add(this);
      });
    }
  }
}

class NotificationProvider with ChangeNotifier {
  StreamController<NotificationItem> _stream;
  List<NotificationItem> _queue = [];

  NotificationProvider() {
    _stream = StreamController();
    _startListen();
  }

  void _startListen() async {
    await for (final item in _stream.stream) {
      notifyListeners();
      Future.delayed(NotificationBar.dismissDuration, () {
        _queue.remove(item);
      });
    }
  }

  List<NotificationItem> get items => _queue;

  void info(String info) => add(NotificationItem(Type.INFO, info, _stream));

  void success(String info) =>
      add(NotificationItem(Type.SUCCESS, info, _stream));

  void error(String error) => add(NotificationItem(Type.ERROR, error, _stream));

  void loading([String info]) =>
      add(NotificationItem(Type.LOADING, info, _stream));

  void dismissLoading() {
    _queue.removeWhere((item) => item.type == Type.LOADING);
    notifyListeners();
  }

  void dismissItem(int id) {
    _queue.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void add(NotificationItem item) {
    _queue.add(item);
    notifyListeners();
  }

  @override
  void dispose() {
    _stream.close();
    super.dispose();
  }
}

enum Type { INFO, SUCCESS, ERROR, LOADING }
