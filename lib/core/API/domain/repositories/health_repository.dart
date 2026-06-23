// DOMAIN LAYER
// Tiny contract: ask the server whether it is up.
abstract class HealthRepository {
  // Returns true if GET /api/health responded with success.
  Future<bool> checkHealth();
}
