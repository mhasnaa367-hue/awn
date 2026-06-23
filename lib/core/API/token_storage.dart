// One place that holds the user's tokens (accessToken + refreshToken).
//
// - We keep the access token in memory (`_token`) so the interceptor can read
//   it instantly on every request (the interceptor runs synchronously).
// - We also save both tokens to the phone with SharedPreferences so they
//   survive closing and reopening the app.
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessKey = 'accessToken';
  static const String _refreshKey = 'refreshToken';

  // The tokens currently in memory. null/empty means "not logged in".
  static String? _token;
  static String? _refreshToken;

  // The line the interceptor reads to attach the access token.
  static String? get token => _token;

  // The refresh token, needed for /refresh and /logout.
  static String? get refreshToken => _refreshToken;

  // True if we currently have an access token (used to decide the start screen).
  static bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  // Call this once when the app starts (e.g. in main) to load any
  // tokens that were saved from a previous session.
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_accessKey);
    _refreshToken = prefs.getString(_refreshKey);
  }

  // Call this right after a successful login/register/refresh to save the tokens.
  static Future<void> save(String accessToken, [String? refreshToken]) async {
    _token = accessToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, accessToken);

    if (refreshToken != null && refreshToken.isNotEmpty) {
      _refreshToken = refreshToken;
      await prefs.setString(_refreshKey, refreshToken);
    }
  }

  // Call this on logout to remove both tokens.
  static Future<void> clear() async {
    _token = null;
    _refreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
    await prefs.remove(_refreshKey);
  }
}
