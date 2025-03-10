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
            'assets/images/testbackground11.svg',
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
                Get.dialog(Center(
                  child: Container(
                    width: 500,
                    height: 200,
                    color: Colors.white,
                    child: Text("make new habbit niggga"),
                  ),
                ));
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
                    //TODO make function instead of repeating this shit
                    //! dashboard
                    IconButton(
                        onPressed: () => navController.changePage(0),
                        icon: SvgPicture.asset(
                          navController.currentIndex.value == 0
                              ? "assets/images/dashboardcolored.svg"
                              : "assets/images/dashboardUncolored.svg",
                          width:
                              navController.currentIndex.value == 0 ? 32 : 21,
                          height:
                              navController.currentIndex.value == 0 ? 32 : 21,
                        )),
                    //! maps
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: IconButton(
                          onPressed: () => navController.changePage(1),
                          icon: SvgPicture.asset(
                            navController.currentIndex.value == 1
                                ? "assets/images/mapsColored.svg"
                                : "assets/images/mapsUncolored.svg",
                            width:
                                navController.currentIndex.value == 1 ? 35 : 24,
                            height:
                                navController.currentIndex.value == 1 ? 35 : 24,
                          )),
                    ),

                    //! community
                    IconButton(
                        onPressed: () => navController.changePage(2),
                        icon: SvgPicture.asset(
                          navController.currentIndex.value == 2
                              ? "assets/images/ColoredCommunity.svg"
                              : "assets/images/Community.svg",
                          width:
                              navController.currentIndex.value == 2 ? 35 : 24,
                          height:
                              navController.currentIndex.value == 2 ? 35 : 24,
                        )),
                    //! Settings
                    IconButton(
                        onPressed: () => navController.changePage(3),
                        icon: SvgPicture.asset(
                          navController.currentIndex.value == 3
                              ? "assets/images/SettingsColored.svg"
                              : "assets/images/SettingsUncolored.svg",
                          width:
                              navController.currentIndex.value == 3 ? 35 : 24,
                          height:
                              navController.currentIndex.value == 3 ? 35 : 24,
                        )),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
