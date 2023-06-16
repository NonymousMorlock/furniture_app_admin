import 'package:benaiah_admin_app/app/app.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders DashboardView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardView), findsOneWidget);
    });
  });
}
