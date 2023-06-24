import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:benaiah_admin_app/core/services/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Furniture Shop Admin');
    setWindowMinSize(const Size(1280, 720));
    setWindowMaxSize(Size.infinite);
  }

  // Add cross-flavor configuration here
  await init();

  runApp(await builder());
}
