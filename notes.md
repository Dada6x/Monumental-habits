# notes

- column padding in wards work instead of each element padding + should be in width mediaquery \* value
- make verification page as function(destination) coz i want to use it in multiple areas
- fix all textfields and its controllers in the app [login-signup-ver cod-forgetpassword-newpassword]
  when floating action button is pressed it should take you to dashboard and then do the ADD HABIT

dash boards is landpage (your progress and stuf) and make newHabit

map still yet

community oh gosh

settings damn

imagepicker ⟶ middlewares ⟶ homepageappbar titel ⟶ DAshBoard of weeks
⟶ Habit edit and so on

> > MOVING PICTURE IN THE HOMEPAGE

# needs just fixing the images to be beautiful

# also the first time app running the first swipe goes black until the image is loaded

but chatgpt said it wont affect the performance that much
but i dont think it useful coz the widget wont be visible

# homePage without the moving pages[Hello]

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
final NavigationController navController = Get.put(NavigationController());

    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/DarkMode.svg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          drawer: Drawer(
            width: SizeConfig.screenWidth * 0.3,
          ),
          backgroundColor: Colors.transparent,
          extendBody: true,
          //! should be changed according to the page
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() => Text(
                  title(navController.currentIndex.value),
                  style: manrope,
                )),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                    backgroundImage: AssetImage(
                  "assets/images/person.png",
                )),
              )
            ],
          ),

          body: Obx(() => IndexedStack(
                index: navController.currentIndex.value,
                children: navController.pages,
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Obx(() {
            return navController.currentIndex.value != 3
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FloatingActionButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          if (navController.currentIndex.value == 0) {
                            navController.changePage(4);
                            //! the floating action button should be changed to tick used to save habit
                            //$ new map
                          } else if (navController.currentIndex.value == 1) {
                            newMap();
                            //$ new message
                          } else if (navController.currentIndex.value == 2) {
                            newMessage();
                            //$ Save the new habit
                          } else if (navController.currentIndex.value == 4) {
                            navController.changePage(0);
                            // add the habit
                            // flush the info in the 4
                          }
                        },
                        backgroundColor: const Color(orange),
                        child: navController.currentIndex.value == 4
                            ? SvgPicture.asset(
                                "assets/images/true.svg",
                                width: 20,
                                height: 20,
                              )
                            : SvgPicture.asset(
                                "assets/images/plus.svg",
                                width: 23,
                                height: 23,
                              )

                        // color: Color(darkPurple),

                        ),
                  )
                : const SizedBox(); // When index is 3, show nothing (or SizedBox)
          }),
          // When index is 3, show nothing (or SizedBox)

          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNavIcon(
                        navController,
                        0,
                        "assets/images/dashboardcolored.svg",
                        "assets/images/dashboardUncolored.svg"),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: buildNavIcon(
                          navController,
                          1,
                          "assets/images/mapsColored.svg",
                          "assets/images/mapsUncolored.svg"),
                    ),
                    buildNavIcon(
                        navController,
                        2,
                        "assets/images/ColoredCommunity.svg",
                        "assets/images/Community.svg"),
                    buildNavIcon(
                        navController,
                        3,
                        "assets/images/SettingsColored.svg",
                        "assets/images/SettingsUncolored.svg"),
                  ],
                )),
          ),
        ),
      ],
    );

}

//! Bottom navigation bar Icons
Widget buildNavIcon(NavigationController navController, int pageIndex,
String selectedPath, String unselectedPath) {
return IconButton(
onPressed: () => navController.changePage(pageIndex),
icon: SvgPicture.asset(
navController.currentIndex.value == pageIndex
? selectedPath
: unselectedPath,
width: navController.currentIndex.value == pageIndex ? 35 : 24,
height: navController.currentIndex.value == pageIndex ? 35 : 24,
),
);
}
}

//! function from the BAG GODDAMNNNN IT
// it works at least hehe
String title(int PageIndex) {
if (PageIndex == 0) {
return "HomePage";
} else if (PageIndex == 1)
return "Maps";
else if (PageIndex == 2)
return "Community";
else if (PageIndex == 3)
return "Settings";
else if (PageIndex == 4) return "New Habit";
return "";
}

//! when making Maps inshallah
Future newMap() {
return Get.dialog(
const Center(
child: SizedBox(
width: 300,
height: 200,
child: Material(
color: Colors.green,
child: Center(
child: Text("Make new Map"),
),
),
),
),
);
}

//! when making chatting inshallah
Future newMessage() {
return Get.dialog(
const Center(
child: SizedBox(
width: 300,
height: 200,
child: Material(
color: Colors.amber,
child: Center(
child: Text("Make new MESSAGE NIGGA"),
),
),
),
),
);
}

# in the widget you want to back from

    Get.back(result: formattedTime);

# in the widget you wanna back into with [result]

onTap: () async {
//! Open Reminder bottom sheet and wait for the selected time
final time = await Get.bottomSheet(
Reminder(),
isScrollControlled: true,);
if (time != null) {
chosenTime.value = time;}
}

i should think of a way architecure for the data
create habit controller
store
userSelectedDays
HabitsName
HabitsTimeReminder

Light Mode
background 0xFFFFF3E9 creamy
buttons 0xFFFDA758 orange(light)
clouds 0xFFFFDFC1
fonts 0xFF573353 darkpurple
textfields 0xFFAA98A8 lavander

DARKMODE

background 0xFF151437
buttons 0xFFE3DEEF
clouds 0xFFB5A8D5
fonts 0xFFFFFFFF or darkpurple or
textfields 0xFFAA98A8 lavander

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class HabitTable extends StatelessWidget {
final HabitController habitController = Get.find<HabitController>();

// Define the four colors to cycle through
final List<Color> randomRowColors = const [
Color(darkOrange), // Orange
Color(0xFFF65B4E), // Red
Color(0xFF29319F), // Indigo
Color(0xFF973456), // Pink
];

@override
Widget build(BuildContext context) {
DateTime today = DateTime.now();
List<String> weekDays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

    List<String> formattedWeekDays = List.generate(7, (index) {
      DateTime day = today
          .subtract(Duration(days: today.weekday % 7))
          .add(Duration(days: index));
      return "${DateFormat('E').format(day)} ${day.day}";
    });

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Enable horizontal scrolling for habits
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Days of the week row (always visible at the top)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      // Habit label
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Habit",
                          style: manropeFun(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 63,
                      ),
                      // Days of the week row
                      ...formattedWeekDays.map((day) {
                        List<String> parts = day.split(" ");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.8),
                          child: Column(
                            children: [
                              Text(parts[0],
                                  style: manropeFun(context)), // Day name
                              Text(parts[1], style: klasikFun(context)), // Date
                            ],
                          ),
                        );
                      }),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Habit cards (horizontally scrollable)
              Obx(() => Column(
                    children: habitController.habits.map((habit) {
                      int rowIndex = habitController.habits.indexOf(habit);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      habit.name,
                                      style: manropeFun(context).copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(7, (index) {
                                    String dayKey = weekDays[index];
                                    bool isSelected =
                                        habit.selectedDays[dayKey] ?? false;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? randomRowColors[
                                                      rowIndex % 4]
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ),
      ),
    );

}
}

# HOW THE HABIT SHIT WORKS

dashboard ⟶ displaying the habit table
habit info ⟶ displaying the habit details,calender , analytics
habit table ⟶ displaying the habit name and days of repeat
new Habit ⟶ entering new habit to
reminder ⟶ adding reminder
habit controller

THE CALANDER THAT DOSENT SHOW THE UNSELECTED DAYS
but theres proplem so i need to see the abdo's response
if it 1,2,3,4,5,8,7,9,, ..... then this code is not suitable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitCalendar extends StatefulWidget {
final Map<String, bool> selectedDays; // Accept the selectedDays map

HabitCalendar({
super.key,
required this.selectedDays, // Required parameter for selectedDays
});

@override
\_HabitCalendarState createState() => \_HabitCalendarState();
}

class \_HabitCalendarState extends State<HabitCalendar> {
DateTime \_selectedMonth = DateTime.now();

@override
void initState() {
super.initState();
}

void \_changeMonth(int offset) {
setState(() {
\_selectedMonth =
DateTime(\_selectedMonth.year, \_selectedMonth.month + offset, 1);
});
}

@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.all(1.0),
child: Column(
children: [
//! Month Selector
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
IconButton(
icon: Icon(
size: 18,
Icons.arrow_back_ios_new_outlined,
color: Theme.of(context).colorScheme.scrim),
onPressed: () => _changeMonth(-1)),
Text(
DateFormat.yMMMM().format(_selectedMonth),
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Theme.of(context).colorScheme.scrim),
),
IconButton(
icon: Icon(
size: 18,
Icons.arrow_forward_ios_outlined,
color: Theme.of(context).colorScheme.scrim),
onPressed: () => _changeMonth(1)),
],
),
const SizedBox(height: 8),
//! Calendar UI
Expanded(
child: TableCalendar(
firstDay: DateTime(2000, 1, 1),
lastDay: DateTime(2100, 12, 31),
focusedDay: \_selectedMonth,
calendarFormat: CalendarFormat.month,
headerVisible: false,
calendarBuilders: CalendarBuilders(
//! TODAY ##################
todayBuilder: (context, day, focusedDay) {
String dayOfWeek = DateFormat('E').format(day).toLowerCase();
bool isActive = widget.selectedDays[dayOfWeek] ?? false;
int currentDay = DateTime.now().day;
if (!isActive) {
return Padding(
padding: const EdgeInsets.all(1.5),
child: Container(
width: 42,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(9),
color: Theme.of(context).colorScheme.secondaryContainer,
),
child: Column(
children: [
Text(
"$currentDay",
style: TextStyle(
fontWeight: FontWeight.bold,
color: Get.isDarkMode
? altPurple
: const Color(orange)),
),
const SizedBox(height: 9),
],
),
),
);
}
return Padding(
padding: const EdgeInsets.all(1.5),
child: Container(
width: 42,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(9),
color: Theme.of(context).colorScheme.secondaryContainer,
),
child: Column(
children: [
Text(
"$currentDay",
style: TextStyle(
fontWeight: FontWeight.bold,
color: Get.isDarkMode
? altPurple
: const Color(orange)),
),
const SizedBox(height: 9),
Container(
width: 33,
height: 33,
decoration: BoxDecoration(
color: Get.isDarkMode
? altPurple
: const Color(darkOrange),
borderRadius: BorderRadius.circular(6),
),
),
],
),
),
);

                //! THE REST OF DAYS   ##################
              }, defaultBuilder: (context, date, _) {
                int day = date.day;
                String dayOfWeek = DateFormat('E').format(date).toLowerCase();
                bool isActive = widget.selectedDays[dayOfWeek] ?? false;
                if (!isActive) {
                  return Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: Column(
                        children: [
                          Text(
                            "$day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                          ),
                          const SizedBox(height: 9),
                        ],
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: Column(
                      children: [
                        Text(
                          "$day",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.scrim,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Container(
                          width: 33,
                          height: 33,
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? altPurple
                                : const Color(darkOrange),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              daysOfWeekVisible: true,
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: manropeGrey, weekendStyle: manropeGrey),
              rowHeight: SizeConfig.screenHeight * 0.088,
              daysOfWeekHeight: 30,
              calendarStyle: const CalendarStyle(
                  cellPadding: EdgeInsets.all(2), isTodayHighlighted: true),
              availableGestures: AvailableGestures.none,
            ),
          ),
        ],
      ),
    );

}
}
