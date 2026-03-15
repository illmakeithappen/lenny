import 'package:flutter_test/flutter_test.dart';
import 'package:lenny/main.dart';

void main() {
  testWidgets('App starts and shows home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const LennyApp());
    expect(find.text('LENNY'), findsOneWidget);
    expect(find.text('Losfahren!'), findsOneWidget);
  });
}
