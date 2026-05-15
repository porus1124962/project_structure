import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Centralised error handling for the entire application.
///
/// Call [ErrorHandler.init] once in [main], before [runApp]:
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   ErrorHandler.init();
///   // ...
/// }
/// ```
abstract class ErrorHandler {
  ErrorHandler._();

  /// Register global Flutter and platform error callbacks.
  static void init() {
    // Catches widget / framework errors (e.g. overflow, null during build).
    FlutterError.onError = _onFlutterError;

    // Catches all other uncaught async / isolate errors.
    PlatformDispatcher.instance.onError = _onPlatformError;
  }

  // ── Handlers ──────────────────────────────────────────────────────────────

  static void _onFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      // Keep the familiar red error screen visible during development.
      FlutterError.presentError(details);
    } else {
      _report(details.exceptionAsString(), details.stack);
    }
  }

  static bool _onPlatformError(Object error, StackTrace stack) {
    _report(error.toString(), stack);
    return true; // returning true prevents the platform from re-throwing
  }

  // ── Reporting ─────────────────────────────────────────────────────────────

  static void _report(String message, StackTrace? stack) {
    // TODO: plug in your crash-reporting service here, e.g.:
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   Sentry.captureException(error, stackTrace: stack);
    if (kDebugMode) {
      debugPrint('[ErrorHandler] $message');
      if (stack != null) debugPrint(stack.toString());
    }
  }

  // ── Public helpers ─────────────────────────────────────────────────────────

  /// Show a dismissible error toast.
  static void showToast(String message) {
    BotToast.showText(text: message);
  }

  /// Show a full-page error widget inside an existing [Scaffold].
  ///
  /// Usage:
  /// ```dart
  /// if (hasError) return ErrorHandler.buildErrorWidget(
  ///   message: 'Something went wrong',
  ///   onRetry: fetchData,
  /// );
  /// ```
  static Widget buildErrorWidget({
    String message = 'Something went wrong.',
    VoidCallback? onRetry,
  }) =>
      _ErrorWidget(message: message, onRetry: onRetry);
}

/// A reusable full-page error state widget.
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

