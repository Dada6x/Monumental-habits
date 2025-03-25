import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/Theme/themes.dart';
import 'package:monumental_habits/Theme/themes_contoller.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  //$ -------------------controllers--------------------------
  final NavigationController navController = Get.put(NavigationController());
  final HabitController habitController = Get.put(HabitController());
  final PageController _pageController = PageController();
  final ThemesContoller _themesContoller = Get.put(ThemesContoller());
  //$ -------------------controllers--------------------------
  final List<String> lightBackgroundImages = [
    'assets/images/BackGround2.svg',
    'assets/images/bacground22.svg',
    'assets/images/BackGround2.svg',
    'assets/images/bacground22.svg',
  ];
  final List<String> darkBackgroundImages = [
    'assets/images/DarkMode.svg',
    'assets/images/DarkModeMoon.svg',
    'assets/images/DarkMode.svg',
    'assets/images/DarkModeMoon.svg',
  ];
  RxBool isDarkMode = false.obs;
  bool isThemeDark = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: SizeConfig.screenHeight * 0.05,
          child: PageView.builder(
            controller: _pageController,
            itemCount: lightBackgroundImages.length,
            physics:
                const NeverScrollableScrollPhysics(), // Disable manual swipe
            itemBuilder: (context, index) {
              return GetBuilder<NavigationController>(
                builder: (_) => SvgPicture.asset(
                  _themesContoller.isDarkMode.value
                      ? darkBackgroundImages[index]
                      : lightBackgroundImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
        ),
        // Main Content
        Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Drawer(
              width: SizeConfig.screenWidth * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    activeColor: altPurple,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(darkOrange),
                    // activeTrackColor: const Color(lavander),
                    // focusColor: Colors.red,
                    trackOutlineColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    thumbIcon: WidgetStatePropertyAll(Get.isDarkMode
                        ? const Icon(
                            Icons.sunny,
                            color: Color(darkOrange),
                          )
                        : const Icon(
                            Icons.nightlight,
                            color: Color(darkPurple),
                          )),
                    value: isDarkMode.value,
                    onChanged: (value) {
                      isDarkMode.value = value;
                      Get.changeTheme(isDarkMode.value
                          ? Themes().darkMode
                          : Themes().lightMode);
                      navController.darkTheme.value = isDarkMode.value;
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            extendBody: true,
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              surfaceTintColor: Colors.transparent,
              forceMaterialTransparency: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Directionality(
                textDirection: TextDirection.ltr,
                child: Obx(() => Text(title(navController.currentIndex.value),
                    style: manropeFun(context))),
              ),
              centerTitle: true,
              actions: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Obx(() => customAction(
                        context, navController.currentIndex.value)),
                  ),
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
                  ? Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          blurRadius: Get.isDarkMode ? 18 : 30,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ]),
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
                              habitController.addHabit();
                              navController.changePage(0);
                              habitController.reset();
                              FocusManager.instance.primaryFocus?.unfocus();
                              // make the controller empty of the textfield
                            }
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: navController.currentIndex.value == 4
                              ? SvgPicture.asset(
                                  "assets/images/truedark.svg",
                                  color: Get.isDarkMode
                                      ? altPurple
                                      : const Color(darkPurple),
                                  width: 20,
                                  height: 20,
                                )
                              : SvgPicture.asset(
                                  "assets/images/plusdark.svg",
                                  color: Get.isDarkMode
                                      ? altPurple
                                      : const Color(darkPurple),
                                  width: 23,
                                  height: 23,
                                )),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    )),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.tertiary,
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
  if (PageIndex == 0) return "HomePage".tr;
  if (PageIndex == 1) return "Maps".tr;
  if (PageIndex == 2) return "Community".tr;
  if (PageIndex == 3) return "Settings".tr;
  if (PageIndex == 4) return "New Habit".tr;
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

Widget customAction(BuildContext context, int index) {
  if (index == 3) {
    return IconButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.secondaryContainer,
      )),
      onPressed: () {},
      icon: Icon(
        Icons.edit_outlined,
        color: Get.isDarkMode ? Colors.white : const Color(darkPurple),
      ),
    );
  }
  if (index == 4) {
    return const SizedBox();
  }
  return const CircleAvatar();
}
