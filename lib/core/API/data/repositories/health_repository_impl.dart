// DATA LAYER
// Real implementation of the HealthRepository contract.
import 'package:awn/core/API/domain/repositories/health_repository.dart';
import 'package:awn/core/API/data/datasources/health_remote_data_source.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthRemoteDataSource remoteDataSource;

  HealthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> checkHealth() => remoteDataSource.checkHealth();
}
