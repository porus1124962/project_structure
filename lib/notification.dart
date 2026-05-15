// ─────────────────────────────────────────────────────────────────────────────
// Push Notifications (optional)
// ─────────────────────────────────────────────────────────────────────────────
// This file is a placeholder. To enable push notifications:
//
// 1. Add dependencies to pubspec.yaml:
//      firebase_messaging: ^<latest>
//      flutter_local_notifications: ^<latest>
//
// 2. Complete Firebase setup described in config.dart.
//
// 3. Implement a background handler and register it in main():
//
//    @pragma('vm:entry-point')
//    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//      // Handle background message…
//    }
//
//    void main() async {
//      WidgetsFlutterBinding.ensureInitialized();
//      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//      // …
//    }
//
// 4. Request permission and listen for foreground messages in InitialBinding
//    or a dedicated NotificationService:
//
//    final messaging = FirebaseMessaging.instance;
//    await messaging.requestPermission();
//    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//      // Show a local notification or update state.
//    });
//
// ─────────────────────────────────────────────────────────────────────────────

