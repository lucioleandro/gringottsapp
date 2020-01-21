import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gringotts/screens/dashboard.dart';

void main() {
  testWidgets('Should display the main image when the Dashboard is opened', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Should display the transfer feature when the Dashboard is  opened', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));

    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed feature when the Dashboard is  opened', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
//    final iconTransactionFeedFeature = find.widgetWithIcon(FeatureItem, Icons.description);
//    expect(iconTransactionFeedFeature, findsOneWidget);
//    final nameTransactionFeedFeatureItem = find.widgetWithText(FeatureItem, 'Transaction Feed');
//    expect(nameTransactionFeedFeatureItem, findsOneWidget);
    final transactionFeedFeature = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));

    expect(transactionFeedFeature, findsOneWidget);
  });

}

bool featureItemMatcher(Widget widget, String legend, IconData icon) {
  if (widget is FeatureItem) {
    return widget.legend == legend && widget.icon == icon;
  }
  return false;
}