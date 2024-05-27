import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetListExt on List<Widget> {
  void divide({bool dividerAtEnd = false, required Widget divider}) {
    for(int i = 1; i < length; i+=2){
      insert(i,divider);
    }
    if(dividerAtEnd) {
      add(divider);
    }
  }
}