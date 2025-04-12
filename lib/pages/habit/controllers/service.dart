// // lib/services/habit_service.dart
// import 'package:dio/dio.dart';
// import 'package:monumental_habits/main.dart';

// class HabitService {
//   final Dio _dio = Dio();

//   Future<Map<String, dynamic>> fetchHabitData() async {
//     const String apiUrl = 'http://10.0.2.2:8000/api/homepage?order=0';
//     try {
//       final response = await _dio.get(
//         apiUrl,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer ${token!.getString("token")}',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       throw Exception('Exception while fetching data: $e');
//     }
//   }
// }
