import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_structure/services/Network/Url.dart';

/// Call in [setUpAll] for any test group that requires Flutter bindings,
/// persistent storage, or the network-environment singleton.
Future<void> initTestDependencies() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Environment().initConfig(Environment.dev);
}

