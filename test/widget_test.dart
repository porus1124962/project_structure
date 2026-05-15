import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:project_structure/main.dart';
import 'package:project_structure/models/user_model.dart';

import 'helpers/app_test_helper.dart';

void main() {
  setUpAll(initTestDependencies);
  tearDown(Get.reset);

  // ── Smoke test ─────────────────────────────────────────────────────────────
  group('MyApp', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(const MyApp());
      // A single pump renders the first frame (Splash screen).
      // We deliberately avoid pumpAndSettle to skip the 1.5 s nav delay.
      await tester.pump(Duration.zero);
      expect(find.byType(GetMaterialApp), findsOneWidget);
    });
  });

  // ── Model unit tests (no Flutter context needed) ───────────────────────────
  group('UserModel', () {
    const json = {
      'id': '42',
      'name': 'Jane Doe',
      'email': 'jane@example.com',
      'avatar_url': 'https://example.com/avatar.png',
    };

    test('fromJson deserialises all fields', () {
      final user = UserModel.fromJson(json);
      expect(user.id, '42');
      expect(user.name, 'Jane Doe');
      expect(user.email, 'jane@example.com');
      expect(user.avatarUrl, 'https://example.com/avatar.png');
    });

    test('fromJson handles null avatarUrl', () {
      final user = UserModel.fromJson({...json, 'avatar_url': null});
      expect(user.avatarUrl, isNull);
    });

    test('toJson round-trips correctly', () {
      final user = UserModel.fromJson(json);
      expect(user.toJson(), equals(json));
    });

    test('copyWith creates a new instance with updated fields', () {
      final user = UserModel.fromJson(json);
      final updated = user.copyWith(name: 'John Doe');
      expect(updated.name, 'John Doe');
      expect(updated.email, user.email); // unchanged
    });

    test('equality holds when all fields match', () {
      final a = UserModel.fromJson(json);
      final b = UserModel.fromJson(json);
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('inequality when a field differs', () {
      final a = UserModel.fromJson(json);
      final b = a.copyWith(name: 'Different');
      expect(a, isNot(equals(b)));
    });
  });
}
