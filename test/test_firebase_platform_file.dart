import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

class TestFirebasePlatform extends FirebasePlatform {
  TestFirebasePlatform() : super();

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return MethodChannelFirebaseApp(
      name,
      const FirebaseOptions(
        apiKey: 'AIzaSyDKTOfYl5O6p7WI5R0E0ZRZEYhDlvGty9A',
        appId: '1:483327833252:web:957360afce875a3aeda231',
        messagingSenderId: '483327833252',
        projectId: 'diliveryboyapp',
      ),
    );
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name = defaultFirebaseAppName,
    FirebaseOptions? options,
  }) async {
    return app(name ?? defaultFirebaseAppName);
  }
}
