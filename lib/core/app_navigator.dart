import 'package:flutter/material.dart';

import 'package:awn/core/routesManager.dart';

// A global handle to the app's Navigator so non-widget code (like the Dio
// interceptor) can navigate — e.g. force a logout when the session expires.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

// Send the user back to the login screen and clear the whole back stack.
// Safe to call from anywhere. Does nothing if the navigator isn't ready, if
// we're already on login, or if we're still on the splash screen (during
// startup the splash screen decides routing itself, so we don't fight it).
void forceLogoutToLogin() {
  final navigator = appNavigatorKey.currentState;
  if (navigator == null) return;

  // Peek at the current top route's name without actually popping anything.
  String? currentName;
  navigator.popUntil((route) {
    currentName = route.settings.name;
    return true;
  });

  if (currentName == RoutesManager.loginsrceen ||
      currentName == RoutesManager.Splashscreen) {
    return;
  }

  navigator.pushNamedAndRemoveUntil(
    RoutesManager.loginsrceen,
    (route) => false,
  );
}
