import 'dart:convert';
import 'dart:io';

import 'package:czy_dojade/models/transport.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test transport fromJson (wroclaw-live.json)', () {
    List<Transport> transports = (jsonDecode(
            File('test/resources/wroclaw-live.json')
                .readAsStringSync())['data'] as Map<String, dynamic>)
        .values
        .map((e) => Transport.fromJson(e))
        .toList();
    expect(transports.isNotEmpty, true);
  });

  test('Test transport fromJson (wroclaw-live2.json)', () {
    List<Transport> transports = (jsonDecode(
            File('test/resources/wroclaw-live2.json')
                .readAsStringSync())['data'] as Map<String, dynamic>)
        .values
        .map((e) => Transport.fromJson(e))
        .toList();
    expect(transports.isNotEmpty, true);
  });
}
