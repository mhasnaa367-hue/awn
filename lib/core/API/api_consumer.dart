abstract class ApiConsumer {
  Future<dynamic> get(
      String path,{
        Object? data,
        Map<String,dynamic>? querParameters
  }
      );
  Future<dynamic> post(
      String path,{
        Object? data,
        Map<String,dynamic>? querParameters
  }
      );
  Future<dynamic> patch(
      String path,{
        Object? data,
        Map<String,dynamic>? querParameters
  }
      );
  Future<dynamic> delete(
      String path,{
        Object? data,
        Map<String,dynamic>? querParameters
  }
      );

}