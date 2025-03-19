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
