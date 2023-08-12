// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:lmg_news_app_demo/views/news_page.dart';

void main() {
  testWidgets('NewsPage shows loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: NewsPage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
