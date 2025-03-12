import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NavigationController navController = Get.put(NavigationController());
  final HabitController habitController = Get.put(HabitController());
  final PageController _pageController =
      PageController(); // Controls background images

  final List<String> backgroundImages = [
    'assets/images/BackGround2.svg', // HomePage
    'assets/images/bacground22.svg', // Community
    'assets/images/DarkModeMoon.svg', // Maps
    'assets/images/BackGround2.svg', // HomePage
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background PageView
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController,
            itemCount: backgroundImages.length,
            physics:
                const NeverScrollableScrollPhysics(), // Disable manual swipe
            itemBuilder: (context, index) {
              return SvgPicture.asset(
                backgroundImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
        ),

        // Main Content
        Scaffold(
          drawer: Drawer(width: SizeConfig.screenWidth * 0.3),
          backgroundColor: Colors.transparent,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() =>
                Text(title(navController.currentIndex.value), style: manrope)),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(),
              )
            ],
          ),
          body: Obx(() => IndexedStack(
                index: navController.currentIndex.value,
                children: navController.pages,
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Obx(() => navController.currentIndex.value != 3
                ? FloatingActionButton(
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
                        habitController.saveHabit();
                        navController.changePage(0);
                        habitController.reset();
                        // make the controller empty of the textfield

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
                          ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )),
          ),
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
      onPressed: () {
        navController.changePage(pageIndex);
        _pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
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

//! Function to get page title
String title(int PageIndex) {
  if (PageIndex == 0) return "HomePage";
  if (PageIndex == 1) return "Maps";
  if (PageIndex == 2) return "Community";
  if (PageIndex == 3) return "Settings";
  if (PageIndex == 4) return "New Habit";
  return "";
}

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
