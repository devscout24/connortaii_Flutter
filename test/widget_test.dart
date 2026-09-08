// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:connortaii_app/helpers/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      diSetup();
    });

    expect(locator.isRegistered<GetStorage>(), true);
  });
}
