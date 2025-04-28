import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/services/Theme/themes.dart';
import 'package:monumental_habits/services/Theme/themes_contoller.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/pages/habit/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/settings_profile/profile.dart';
import 'package:monumental_habits/pages/settings_profile/support/profile_details.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //$ -------------------controllers-------------------------)
  final NavigationController navController = Get.put(NavigationController());
  final HabitController habitController = Get.put(HabitController());
  final PageController _pageController = PageController();
  final ThemesContoller _themesController = Get.put(ThemesContoller());

  //$ -------------------controllers--------------------------)
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
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
                      _themesController.isDarkMode.value
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
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              drawer: Drawer(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      // Your top section (navigation icons and theme switcher)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                drawerNavIcon(navController, 0,
                                    "assets/images/dashboardcolored.svg"),
                                Divider(
                                  endIndent: 5,
                                  indent: 5,
                                  thickness: 0.9,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                drawerNavIcon(navController, 1,
                                    "assets/images/mapsColored.svg"),
                                Divider(
                                  endIndent: 5,
                                  indent: 5,
                                  thickness: 0.9,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                drawerNavIcon(navController, 2,
                                    "assets/images/ColoredCommunity.svg"),
                                Divider(
                                  endIndent: 5,
                                  indent: 5,
                                  thickness: 0.9,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                drawerNavIcon(navController, 3,
                                    "assets/images/SettingsColored.svg"),
                                const SizedBox(height: 10),
                              ],
                            ),
                            const Spacer(),
                            Switch(
                              activeColor: altPurple,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(darkOrange),
                              trackOutlineColor: const WidgetStatePropertyAll(
                                  Colors.transparent),
                              thumbIcon: WidgetStatePropertyAll(Get.isDarkMode
                                  ? const Icon(Icons.nightlight,
                                      color: Colors.white)
                                  : const Icon(Icons.sunny,
                                      color: Color(darkOrange))),
                              value: _themesController.isDarkMode.value,
                              onChanged: (value) {
                                _themesController.isDarkMode.value = value;
                                Get.changeTheme(
                                    _themesController.isDarkMode.value
                                        ? Themes().darkMode
                                        : Themes().lightMode);
                                navController.darkTheme.value =
                                    _themesController.isDarkMode.value;
                              },
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: GestureDetector(
                                onLongPress: () {
                                  Get.snackbar("🐣 Easter Egg!",
                                      "You unlocked the Ultra Focus Mode!");
                                },
                                child: const Text("v1.0.0"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                                // Get.off(() => NewHabit());
                                //$ new map
                              } else if (navController.currentIndex.value ==
                                  1) {
                                //$ new message
                              } else if (navController.currentIndex.value ==
                                  2) {
                                //$ Save the new habit
                              } else if (navController.currentIndex.value ==
                                  4) {
                                if (habitController.habitName.isNotEmpty &&
                                    habitController.selectedDays.isNotEmpty) {
                                  //todo and another things also
                                  habitController.addHabit();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.off(() => HomePage());
                                  habitController.reset();
                                }
                                navController.changePage(0);
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
          ],
        ),
      ),
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

  Widget drawerNavIcon(
    NavigationController navController,
    int pageIndex,
    String selectedPath,
  ) {
    return IconButton(
      onPressed: () {
        navController.changePage(pageIndex);
        _pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        Navigator.of(context).pop();
      },
      icon: SvgPicture.asset(
        selectedPath,
        width: 35,
        height: 35,
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

//! when making chatting inshallah

Widget customAction(
  BuildContext context,
  int index,
) {
  if (index == 3) {
    return IconButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.secondaryContainer,
      )),
      onPressed: () {
        Get.to(() => ProfileDetails());
      },
      icon: Icon(
        Icons.edit_outlined,
        color: Get.isDarkMode ? Colors.white : const Color(darkPurple),
      ),
    );
  }
  if (index == 4 || index == 5) {
    return const SizedBox();
  }
  return GestureDetector(
      onTap: () {
        Get.to(() => ProfilePage());
      },
      //! @ward do the Profile IMage you Nigger
      child: const CircleAvatar());
}
