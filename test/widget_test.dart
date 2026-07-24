// Basic smoke test: the app boots, loads portfolio.json from assets, and
// renders the visitor's name from the JSON once loading finishes.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shakhawat_portfolio/main.dart';

void main() {
  testWidgets('Portfolio app loads JSON content and shows the hero name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    // First frame: the JSON asset hasn't finished loading yet.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let the asset load + parse complete.
    await tester.pumpAndSettle();

    expect(find.textContaining('Shakhawat'), findsWidgets);
    expect(find.text('Senior iOS Developer'), findsWidgets);
  });
}
