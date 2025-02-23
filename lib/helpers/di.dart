//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

void diSetup() {
  locator.registerSingleton<GetStorage>(GetStorage());
  // locator.registerSingleton<WebViewController>(WebViewController());
  // locator.registerSingleton<GenericDi>(GenericDi());
  
}
