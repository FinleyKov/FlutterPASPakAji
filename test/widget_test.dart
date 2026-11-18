import 'package:flutter_test/flutter_test.dart';
import 'package:pasflutter/main.dart';

void main() {
  testWidgets('App loads Login Page properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Kuliner & Liga Inggris'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
