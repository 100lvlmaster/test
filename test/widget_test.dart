// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_twitter/blocs/home/home_bloc.dart';

import 'package:test_twitter/main.dart';
import 'package:test_twitter/respository/twitter.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    TwitterRepository twitterRepository;
    HomeBloc homeBloc;
    // init
    setUp(() {
      twitterRepository = TwitterRepository();
      homeBloc = HomeBloc();
    });

    // dispose
    tearDown(() {
      homeBloc?.close();
    });
    // tests
    test('render timeline', () {
      expect(twitterRepository.fetchProfile(), RenderTimeline([]));
    });
  });
}
