// Holds the logged-in user in ONE place so screens share it instead of each
// calling /api/auth/me on every rebuild.
//
// - `ensureLoaded()` fetches the user once and caches it. Calling it again is a
//   no-op, so opening the drawer repeatedly does NOT hit the network.
// - `refresh()` forces a re-fetch (e.g. pull to refresh, after verifying email).
// - The profile picture chosen from the phone is stored locally (its file path
//   is persisted) because the backend has no avatar-upload endpoint — so it is
//   shown across the app but lives on the device only.
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/entities/user.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';

class UserProvider extends ChangeNotifier {
  final AuthRepository _auth = createAuthRepository();
  static const String _avatarKey = 'local_avatar_path';

  User? _user;
  String? _localAvatarPath;
  bool _loaded = false;
  bool _loading = false;

  User? get user => _user;
  String? get localAvatarPath => _localAvatarPath;
  bool get isLoaded => _loaded;
  bool get isLoading => _loading;
  String get name => _user?.name ?? '';
  String get email => _user?.email ?? '';
  bool get isVerified => _user?.isVerified ?? false;

  // Fetch once and cache. Safe to call from every screen's initState.
  Future<void> ensureLoaded() async {
    if (_loaded || _loading) return;
    await refresh();
  }

  // Force a fresh fetch from the server.
  Future<void> refresh() async {
    _loading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      _localAvatarPath = prefs.getString(_avatarKey);
      _user = await _auth.getMe();
      _loaded = true;
      notifyListeners();
    } catch (_) {
      // Keep whatever we already had (e.g. offline).
    } finally {
      _loading = false;
    }
  }

  // Save the picked profile picture (device-local) and show it everywhere.
  Future<void> setLocalAvatar(String path) async {
    _localAvatarPath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_avatarKey, path);
    notifyListeners();
  }

  // Update the name on the server and in the cache.
  Future<void> updateName(String newName) async {
    _user = await _auth.updateProfile(name: newName);
    notifyListeners();
  }

  // Drop everything on logout so the next user starts clean.
  Future<void> clear() async {
    _user = null;
    _localAvatarPath = null;
    _loaded = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarKey);
  }
}
