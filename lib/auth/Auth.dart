import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monumental_habits/auth/SIgnupForm.dart';
import 'package:monumental_habits/auth/loginform.dart';
import 'package:monumental_habits/util/helper.dart';

import 'package:monumental_habits/widgets/animationbutton.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //! idk what dose constraints is anyway wallahi
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      "assets/images/splachScreen.png",
                      width: width,
                      height: height * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Flexible(child: SizedBox()),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.05, right: width * 0.05),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("assets/images/question.svg")
                ),
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: animatedGoogleButton(),
              )),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: 0,
                left: 0,
                right: 0,
                height: isExpanded ? height * 0.94 : height * 0.39,
                child: Container(
                  decoration: BoxDecoration(
                    color: isExpanded ? const Color(background) : Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(23)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Text(
                            isExpanded
                                ? "Signup with Email"
                                : "Login with Email",
                            style: klasik,
                          ),
                        ),
                        isExpanded ?  SignupForm() : LoginForm(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(isExpanded
                                ? "Already Have an account ?"
                                : "Don’t have an account ?"),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? "Login" : "Sign up",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(orange),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
