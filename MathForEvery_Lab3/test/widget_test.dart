import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:three_pam/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construim aplicația noastră și declanșăm un cadru.
    await tester.pumpWidget(const MyApp());

    // Verificăm că numărătorul nostru începe de la 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Apasati butonul "+" și declanșați un cadru.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verificăm dacă contorul nostru a crescut.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
