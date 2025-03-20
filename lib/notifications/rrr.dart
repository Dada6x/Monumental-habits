// import 'package:flutter/material.dart';
// import 'package:monumental_habits/notifications/notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationSchedulerScreen extends StatefulWidget {
//   @override
//   _NotificationSchedulerScreenState createState() =>
//       _NotificationSchedulerScreenState();
// }

// class _NotificationSchedulerScreenState
//     extends State<NotificationSchedulerScreen> {
//   // Variables to store the selected date and time
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;

//   // Function to show date picker
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       ////
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   // Function to show time picker
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (pickedTime != null) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   // Function to schedule the notification
//   void _scheduleNotification() {
//     if (_selectedDate == null || _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("⚠ Please select both date and time.")),
//       );
//       return;
//     }

//     // Combine date and time into a single DateTime object
//     DateTime scheduledDateTime = DateTime(
//       _selectedDate!.year,
//       _selectedDate!.month,
//       _selectedDate!.day,
//       _selectedTime!.hour,
//       _selectedTime!.minute,
//     );
//     if (scheduledDateTime.isBefore(tz.TZDateTime.now(tz.local))) {
//       debugPrint(" this is passed time ");
//     } else {
//       // Schedule the notification (✅ Use the correct method)
//       NotificationService.scheduleDailyInstantNotification(
//         title: "Reminder 🕰",
//         body: "This is your scheduled notification!",

//         // ! in this line we need to make a days num chang as a user input it ///
//         daysAfter: 5,
//         scheduleDate: scheduledDateTime,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Notification scheduled successfully!")),
//       );

//       debugPrint("⏰ Notification set for: $scheduledDateTime");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("📅 Schedule Notification")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Date Picker Button
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text(
//                 _selectedDate == null
//                     ? "📆 Select Date"
//                     : "📆 Date: ${_selectedDate!.toLocal()}".split(' ')[0],
//               ),
//             ),
//             SizedBox(height: 20),

//             // Time Picker Button
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text(
//                 _selectedTime == null
//                     ? "⏰ Select Time"
//                     : "⏰ Time: ${_selectedTime!.format(context)}",
//               ),
//             ),
//             SizedBox(height: 20),

//             // Schedule Notification Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: _scheduleNotification,
//                 child: Text("✅ Schedule Notification"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
