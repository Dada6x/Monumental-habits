import 'package:monumental_habits/Core/api/end_points.dart';

class ErrorModel {
  //!  // THIS COULD BE DIFFRENT DEPENDING ON THE RESPONSE OF API
  final int statusCode;
  final String message; // could be message/body/errormessage/...etc

  const ErrorModel(this.statusCode, this.message);
  //wtf is factory
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      jsonData[ApiKey.status],
      jsonData[ApiKey.errorMessage],
    );
  }
}
