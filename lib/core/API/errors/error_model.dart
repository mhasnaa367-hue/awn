class ErrorModel {
  late final int status;
  late final int errorMassage;

  ErrorModel({required this.errorMassage, required this.status});

  factory ErrorModel.fromjson(Map<String, dynamic> jsonData) {
    return ErrorModel(
        errorMassage: jsonData['ErrorMassage'],
        status: jsonData['Status'],);
  }
}
