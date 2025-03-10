import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/util/helper.dart';

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
          backgroundColor: Colors.transparent,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            title: const Text(
              "HomePage",
              style: manrope,
            ),
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
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                navController.changePage(0);
                Get.dialog(
                  const Center(
                    child: SizedBox(
                      width: 500,
                      height: 200,
                      child: Material(
                        color: Colors.white,
                        child: Center(
                          child: Text("Make new habit"),
                        ),
                      ),
                    ),
                  ),
                );
              },
              backgroundColor: const Color(orange),
              child: const Icon(Icons.add, size: 30, color: Color(darkPurple)),
            ),
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

  /// **Reusable function to build Bottom Navigation Icons**
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
