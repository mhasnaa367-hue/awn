// All the server addresses (paths) live here in one place.
class EndPoint {
  // The main server address. The full URL becomes baseUrl + path.
  static String baseUrl = 'https://awn-production-edb2.up.railway.app/';

  static String login = '/api/auth/login';
  static String register = '/api/auth/register';
}

// The names of the JSON fields we send/read. Keeping them here avoids typos.
class ApiKey {
  static String name = 'name';
  static String email = 'email';
  static String password = 'password';
  static String message = 'message'; // server uses "message" for errors
}
