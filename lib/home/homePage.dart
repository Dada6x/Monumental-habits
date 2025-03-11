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
            height: MediaQuery.of(context).size.height,
            backGround2,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          drawer: Drawer(
            width: SizeConfig.screenWidth * 0.3,
          ),
          backgroundColor: Colors.transparent,
          extendBody: true,
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
                          newHabbit();
                          //! the floating action button should be changed to tick used to save habit
                        } else if (navController.currentIndex.value == 1) {
                          newMap();
                        } else if (navController.currentIndex.value == 2) {
                          newMessage();
                        } else if (navController.currentIndex.value == 3) {
                          // Optionally handle index 3 here if needed
                        }
                      },
                      backgroundColor: const Color(orange),
                      child: const Icon(Icons.add,
                          size: 30, color: Color(darkPurple)),
                    ),
                  )
                : SizedBox(); // When index is 3, show nothing (or SizedBox)
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
  else if (PageIndex == 3) return "Settings";
  return "";
}

Future newHabbit() {
  return Get.dialog(
    const Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: Material(
          color: Color(orange),
          child: Center(
            child: Text("Make new habit"),
          ),
        ),
      ),
    ),
  );
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
