import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/provides.dart';

final locator = GetIt.instance;
GetStorage get appData => locator.get<GetStorage>();
//final db = locator<SqfLiteService>();

void diSetup() {
  locator.registerLazySingleton(() => FirebaseMessaging.instance);
  locator.registerSingleton<GetStorage>(GetStorage());
  locator.registerLazySingleton<WebViewController>(() => WebViewController());
  locator.registerSingleton<DistanceProvider>(DistanceProvider());
  locator.registerSingleton<GenericDi>(GenericDi());
  locator.registerSingleton<PlcaeMarkAddress>(PlcaeMarkAddress());
  //locator.registerSingleton<SqfLiteService>(SqfLiteService());
}
