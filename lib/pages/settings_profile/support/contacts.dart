import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/Buttons.dart';

import 'package:monumental_habits/util/widgets/customappBar.dart';
import 'package:monumental_habits/util/widgets/settingsFunctions.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar([], "Contacts".tr, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text("------------  info  ------------ ".tr,
                  style: headerStyle(context)),
            ),
            SettingsFunctions(
              text: "team.habitly@gmail.com",
              leading: "Email us :".tr,
              textToCopy: "team.habitly@gmail.com",
              whatsCopied: "Email",
            ),
            SettingsFunctions(
              text: "+963-965455216\n+963-980817760 ", //! added my number
              leading: "Call us :".tr,
              textToCopy: "+963-965455216",
              whatsCopied: "Number",
            ),
            SettingsFunctions(
              text: "Help Your Friends and Family develop Healthy habits".tr,
              leading: "Share Habitly ".tr,
              textToCopy: "http://google.com",
              whatsCopied: "App Link",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Theme.of(context).colorScheme.tertiary,
                child: ListTile(
                  onLongPress: () {},
                  title: Text(
                    "our Socials:".tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.facebook,
                            color: Color.fromARGB(255, 22, 31, 167),
                            size: 45,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.telegram,
                            color: Colors.blue,
                            size: 40,
                          )),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF833AB4), // Purple
                            Color(0xFFFD1D1D), // Red
                            Color(0xFFFCAF45),
                          ],
                        ).createShader(bounds),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 45,
                            )),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.xTwitter,
                            color: Colors.grey,
                            size: 40,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Text("------------  FeedBack  ------------ ".tr,
                  style: headerStyle(context)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 10.0, right: MediaQuery.of(context).size.width * 0.5),
              child: Text(
                "We value your feedBack !".tr,
                style: manropeFun(context),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 130.0),
                    child: Icon(
                      Icons.feedback,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  hintText: "Write it Here".tr,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                  vertical: 20),
              child: Button(context, "Enter".tr, () {}),
            )
          ],
        ),
      ),
    );
  }
}
