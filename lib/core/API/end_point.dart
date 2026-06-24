// All the server addresses (paths) live here in one place.
class EndPoint {
  // The main server address. The full URL becomes baseUrl + path.
  static String baseUrl = 'https://awn-production-edb2.up.railway.app/';

  // ---- Health ----
  static String health = '/api/health';

  // ---- Auth ----
  static String login = '/api/auth/login';
  static String register = '/api/auth/register';
  static String me = '/api/auth/me'; // GET profile + PATCH update profile
  static String changePassword = '/api/auth/change-password';
  static String refresh = '/api/auth/refresh';
  static String logout = '/api/auth/logout';
  static String logoutAll = '/api/auth/logout-all';

  // ---- Password reset (forgot password) ----
  static String forgotPassword = '/api/auth/forgot-password'; // body: { email }
  static String resetPassword =
      '/api/auth/reset-password'; // body: { email, code, newPassword }

  // ---- Email verification (OTP) ----
  static String sendOtp = '/api/auth/send-otp';
  static String verifyEmail = '/api/auth/verify-email';
  static String resendOtp = '/api/auth/resend-otp';

  // ---- Documents ----
  // Send a file (image or PDF) to be summarized by the AI.
  static String uploadDocument = '/api/documents/upload';
  static String documents = '/api/documents'; // GET list (page, limit, status)

  // Single-document paths (need the document id).
  static String document(String id) => '/api/documents/$id';
  static String documentStatus(String id) => '/api/documents/$id/status';
  static String refreshTopicVideos(String id, int topicIndex) =>
      '/api/documents/$id/topics/$topicIndex/videos/refresh';
}

// The names of the JSON fields we send/read. Keeping them here avoids typos.
class ApiKey {
  // Common request fields.
  static String name = 'name';
  static String email = 'email';
  static String password = 'password';
  static String avatar = 'avatar';
  static String currentPassword = 'currentPassword';
  static String newPassword = 'newPassword';
  static String code = 'code'; // OTP code
  static String refreshToken = 'refreshToken';

  // Common response fields.
  static String message = 'message'; // server uses "message" for errors
  static String data = 'data'; // server wraps results inside a "data" object
  static String success = 'success';
  static String user = 'user'; // the user object inside "data"
  static String accessToken = 'accessToken';
  static String expiresInMinutes = 'expiresInMinutes';

  // User fields.
  static String id = '_id'; // shared id key across user/document
  static String isVerified = 'isVerified';
  static String isActive = 'isActive';

  // Document fields.
  static String file = 'file'; // the form field that holds the uploaded file
  static String document = 'document'; // the uploaded document object
  static String documents = 'documents'; // list of documents
  static String pagination = 'pagination';
  static String page = 'page';
  static String limit = 'limit';
  static String total = 'total';
  static String totalPages = 'totalPages';
  static String status = 'status'; // pending / processing / done / failed
  static String errorMessage = 'errorMessage';
  static String originalName = 'originalName'; // the file name the user picked
  static String fileType = 'fileType';
  static String fileSize = 'fileSize';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';

  // Topic / video fields (inside a "done" document).
  static String topics = 'topics';
  static String title = 'title';
  static String summary = 'summary';
  static String videos = 'videos';
  static String videoId = 'videoId';
  static String url = 'url';
  static String thumbnail = 'thumbnail';
  static String channel = 'channel';
}
