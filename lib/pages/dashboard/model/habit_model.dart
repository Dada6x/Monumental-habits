// import 'package:uuid/uuid.dart';

// var uuid = Uuid(); // Create a UUID generator

class Habit {
  // String id;  // Unique habit ID using UUID
  String name;
  String chosenTime;
  bool notificationsEnabled;
  Map<String, bool> selectedDays;

  Habit({
    // required this.id,
    required this.name,
    required this.chosenTime,
    required this.notificationsEnabled,
    required this.selectedDays,
  });

  // Generate a unique ID using UUID
  // static String generateUniqueId() {
  //   return uuid.v4(); // Generates a version-4 UUID (random)
  // }
}

/*
I/flutter (18789): name 
I/flutter (18789): 11:10 AM
I/flutter (18789): true
I/flutter (18789): {sun: true, mon: true, tue: true, wed: true, thu: true, fri: true, sat: true}
*/