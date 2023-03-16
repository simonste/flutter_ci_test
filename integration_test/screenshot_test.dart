import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_ci/main.dart' as app;

// https://dev.to/mjablecnik/take-screenshot-during-flutter-integration-tests-435k

takeScreenshot(tester, binding, name) async {
  if (Platform.isAndroid) {
    await tester.pumpAndSettle();
  }
  await binding.takeScreenshot(name);
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  // remove debug banner for screenshots
  WidgetsApp.debugAllowBannerOverride = false;

  setUp(() async {});
  testWidgets('test #1', (tester) async {
    app.main();
    await binding.convertFlutterSurfaceToImage();

    await tester.pumpAndSettle();

    await takeScreenshot(tester, binding, 'screenshot1');

    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byTooltip('Increment'));
    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();

    await takeScreenshot(tester, binding, 'screenshot2');
  });
}
