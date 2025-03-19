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
