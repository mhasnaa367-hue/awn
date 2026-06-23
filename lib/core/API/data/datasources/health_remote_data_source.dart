// DATA LAYER
// Talks to GET /api/health (no auth required).
import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/end_point.dart';

abstract class HealthRemoteDataSource {
  Future<bool> checkHealth();
}

class HealthRemoteDataSourceImpl implements HealthRemoteDataSource {
  final ApiConsumer api;

  HealthRemoteDataSourceImpl({required this.api});

  @override
  Future<bool> checkHealth() async {
    final response = await api.get(EndPoint.health);
    if (response is Map) {
      return response[ApiKey.success] == true;
    }
    return false;
  }
}
