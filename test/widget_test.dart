import 'package:flutter_test/flutter_test.dart';

import 'package:gimnasio_app/main.dart';

void main() {
  testWidgets('muestra la pantalla de membresías', (tester) async {
    await tester.pumpWidget(const MiAplicacion());

    await tester.pumpAndSettle();

    expect(find.text('Membresías'), findsOneWidget);
    expect(find.text('Carlos Perez'), findsOneWidget);
    expect(find.text('Ana Gomez'), findsOneWidget);
    expect(find.text('Luis Martinez'), findsOneWidget);
    expect(find.text('Maria Rodriguez'), findsOneWidget);
  });
}