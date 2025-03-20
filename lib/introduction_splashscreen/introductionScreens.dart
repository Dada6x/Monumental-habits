import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intropages extends StatefulWidget {
  const Intropages({super.key});

  @override
  State<Intropages> createState() => _IntropagesState();
}

class _IntropagesState extends State<Intropages> {
  final _pageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (pageIndex) {
            setState(() {
              onLastPage = (pageIndex == 2);
              // if the last page is the current page (using onPageChanged) return true
            });
          },
          controller: _pageController,
          children: [
            intro(
              svgAsset: intro1,
              upperDescription: "",
              downDescription: "",
            ),
            intro(svgAsset: intro2, upperDescription: "", downDescription: ""),
            intro(svgAsset: intro3, upperDescription: "", downDescription: ""),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.89),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(3);
                },
                child: const Text(
                  'Skip',
                  style: klasik,
                ),
              ), //! the page indicator
              SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const SlideEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Color(darkPurple),
                      dotColor: Color(orange))),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Get.to(const camp());
                      },
                      child: const Text('Done', style: klasik),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: const Text(
                        'Next',
                        style: klasik,
                      ),
                    )
            ],
          ),
        )
      ],
    ));
  }
}

Widget intro(
    {required String svgAsset,
    required String upperDescription,
    required String downDescription}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 29),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            upperDescription,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Center(child: SvgPicture.asset(svgAsset)),
        Center(
          child: Text(
            downDescription,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ],
    ),
  );
}

//! the last intro with the button
class camp extends StatelessWidget {
  const camp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(intro4),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Button("Get Started", () {
                Get.to(const Auth());
              }))
        ],
      ),
    );
  }
}
