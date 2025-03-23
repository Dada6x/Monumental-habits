class Habit {
  String name;
  String chosenTime;
  bool notificationsEnabled;
  Map<String, bool> selectedDays;

  Habit({
    required this.name,
    required this.chosenTime,
    required this.notificationsEnabled,
    required this.selectedDays,
  });
}
/*
I/flutter (18789): name 
I/flutter (18789): 11:10 AM
I/flutter (18789): true
I/flutter (18789): {sun: true, mon: true, tue: true, wed: true, thu: true, fri: true, sat: true}
*/