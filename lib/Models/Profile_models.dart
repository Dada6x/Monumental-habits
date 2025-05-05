import 'package:dio/dio.dart';
import 'package:monumental_habits/main.dart';

class ProfileModels {
  static Future<bool> UpdateUserRequest(String? name, String? FilePath) async {
    FormData data = FormData();

    if (name == null && FilePath != null) {
      data =
          FormData.fromMap({"photo": await MultipartFile.fromFile(FilePath)});
    }
    if (name != null && FilePath == null) {
      data = FormData.fromMap({"name": name});
    }
    final response = await Dio().post("http://10.0.2.2:8000/api/profile/update",
        options: Options(headers: {
          "Authorization": "Bearer ${token!.getString("token")}",
        }),
        data: data);
    if (response.data["status"]) {
      return response.data["status"];
    }
    return false;
  }
}
