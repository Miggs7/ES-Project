import 'package:flutter_test/flutter_test.dart';

Future<void> iSee(WidgetTester tester, dynamic param1) async {
  expect(find.textContaining('Não há fila mais proxima'),findsOneWidget);
}