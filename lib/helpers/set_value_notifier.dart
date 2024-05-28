import 'package:flutter/cupertino.dart';

class SetValueNotifier<T> extends ValueNotifier<T> {

  SetValueNotifier(T val) : super(val);

  void notify() {
    notifyListeners();
  }
}