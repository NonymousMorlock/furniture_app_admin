import 'package:benaiah_admin_app/core/services/router.dart';
import 'package:benaiah_admin_app/src/dashboard/presentation/views/home_view.dart';
import 'package:flutter/widgets.dart';

class DashboardController extends ChangeNotifier {
  int _currentIndex = 0;
  bool _extended = false;

  int get currentIndex => _currentIndex;

  bool get extended => _extended;

  String get pageTitle => _currentIndex == 0
      ? 'Dashboard'
      : _currentIndex == 1
          ? 'Activity'
          : 'Settings';

  final List<RouteSettings> _nestedStack = [
    const RouteSettings(name: HomeView.routeName),
  ];

  bool get canPop => _nestedStack.length > 1;

  Widget get currentScreen => generateRoute(_nestedStack.last);

  void push(String routeName, {Object? arguments}) {
    _nestedStack.add(RouteSettings(name: routeName, arguments: arguments));
    notifyListeners();
  }

  void pop({Object? arguments}) {
    _nestedStack.removeLast();
    if (arguments != null) {
      final lastRoute = _nestedStack.removeLast();
      _nestedStack
          .add(RouteSettings(name: lastRoute.name, arguments: arguments));
    }
    notifyListeners();
  }

  void pushReplacement(String routeName, {Object? arguments}) {
    _nestedStack..removeLast()
    ..add(RouteSettings(name: routeName, arguments: arguments));
    notifyListeners();
  }

  void popUntil(String routeName, {Object? arguments}) {
    while (_nestedStack.last.name != routeName) {
      _nestedStack.removeLast();
    }
    _nestedStack
      ..removeLast()
      ..add(RouteSettings(name: routeName, arguments: arguments));
    notifyListeners();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void extend() {
    _extended = true;
    notifyListeners();
  }

  void retract() {
    _extended = false;
    notifyListeners();
  }
}
