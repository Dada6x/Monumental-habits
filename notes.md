# notes
* column padding in wards work instead of each element padding + should be in width mediaquery * value
* make verification page as function(destination) coz i want to use it in multiple areas 
* fix all textfields and its controllers in the app [login-signup-ver cod-forgetpassword-newpassword]
when floating action button is pressed it should take you to dashboard and then do the ADD HABIT 


dash boards is landpage (your progress and stuf) and make newHabit 

map still yet

community oh gosh 

settings damn 


imagepicker ⟶ middlewares ⟶ homepageappbar titel ⟶ DAshBoard of weeks 
⟶ Habit edit and so on 




Get.off(PersonalInfo(), arguments: {
                //! how to pass the arguments dammmn
                // "email": emailController.text,
                // "isChecked": isChecked.value, // Pass checkbox value
                //! and this how to recive them in the personalInfo class
                // final String email = Get.arguments["email"];
                // final bool isChecked = Get.arguments["isChecked"];

                the add button should be only to the habits table adding ????
                or maybe if dashboard ⟶ add habit   
                        in maps ⟶ add map 
                        in community add message
                        in profile dose'nt appear  











>> MOVING PICTURE IN THE HOMEPAGE
# needs just fixing the images to be beautiful
# also the first time app running the first swipe goes black until the image is loaded
but chatgpt said it wont affect the performance that much 
but i dont think it useful coz the widget wont be visible  


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NavigationController navController = Get.put(NavigationController());
  final PageController _pageController = PageController(); // Controls background images

  final List<String> backgroundImages = [
    'assets/images/BackGround2.svg', // HomePage
    'assets/images/bacground22.svg', // Community
    'assets/images/bacground3.svg', // Maps
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
            physics: const NeverScrollableScrollPhysics(), // Disable manual swipe
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
            title: Obx(() => Text(title(navController.currentIndex.value), style: manrope)),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                navController.changePage(0);
                _pageController.jumpToPage(0); // Reset background to first
                Get.dialog(
                  const Center(
                    child: SizedBox(
                      width: 500,
                      height: 200,
                      child: Material(
                        color: Colors.white,
                        child: Center(child: Text("Make new habit")),
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
                    buildNavIcon(navController, 0, "assets/images/dashboardcolored.svg", "assets/images/dashboardUncolored.svg"),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: buildNavIcon(navController, 1, "assets/images/mapsColored.svg", "assets/images/mapsUncolored.svg"),
                    ),
                    buildNavIcon(navController, 2, "assets/images/ColoredCommunity.svg", "assets/images/Community.svg"),
                    buildNavIcon(navController, 3, "assets/images/SettingsColored.svg", "assets/images/SettingsUncolored.svg"),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  //! Bottom navigation bar Icons
  Widget buildNavIcon(NavigationController navController, int pageIndex, String selectedPath, String unselectedPath) {
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
        navController.currentIndex.value == pageIndex ? selectedPath : unselectedPath,
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
  return "";
}
