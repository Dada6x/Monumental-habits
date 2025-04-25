import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/FAQ_page.dart';
import 'package:monumental_habits/pages/settings_profile/customization.dart';
import 'package:monumental_habits/pages/settings_profile/profile.dart';
import 'package:monumental_habits/pages/settings_profile/support/about.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/pages/settings_profile/support/contacts.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Stack(
                children: [
                  ListTile(
                    title: Text(
                      "Check Your Profile".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.scrim,
                          fontFamily: "klasik",
                          fontSize: 22,
                          fontWeight: FontWeight.w900),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.53,
                            child: Text(
                              "Check Your Info and Current Progress".tr,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: "manrope",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        //Color.fromRGBO(240, 222, 250, 0.8)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primaryFixed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => ProfilePage());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "View".tr,
                                style:  TextStyle(
                                    color: Theme.of(context).colorScheme.scrim,
                                    fontFamily: "klasik",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.025,
                        left: MediaQuery.sizeOf(context).width * 0.65),
                    child: SvgPicture.asset(
                      "assets/images/SettingsColored.svg",
                      width: 250,
                      height: 100,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * 0.02),
          child: Text(
            "General".tr,
            style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontSize: 16,
                fontFamily: "manrope",
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        SettingsTabs(
          title: "Notifications".tr,
          subTitle: "Customize Notifications".tr,
          leadIcon: Icons.circle_notifications_rounded,
          targetPage: CustomizePage(),
        ),
        SettingsTabs(
          title: "More Customization".tr,
          subTitle: "Customize it more to fit your usage".tr,
          leadIcon: Icons.more_horiz,
          targetPage: CustomizePage(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * 0.02),
          child: Text(
            "Support".tr,
            style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontSize: 16,
                fontFamily: "manrope",
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        SettingsTabs(
          title: "Contact us".tr,
          subTitle: null,
          leadIcon: Icons.call,
          targetPage: const ContactsPage(),
        ),
        SettingsTabs(
          title: "FAQ".tr,
          subTitle: null,
          leadIcon: Icons.help,
          targetPage: const FAQPage(),
        ),
        SettingsTabs(
          title: "About Us".tr,
          subTitle: null,
          leadIcon: Icons.info,
          targetPage: const AboutPage(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SettingsTabs extends StatelessWidget {
  SettingsTabs(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leadIcon,
      required this.targetPage});
  final String title;
  String? subTitle;
  final IconData leadIcon;

  Widget targetPage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        child: ListTile(
          onTap: () {
            Get.to(() => targetPage);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          isThreeLine: false,
          leading: Container(
            width: 45,
            height: 45,
            foregroundDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              leadIcon,
              size: 27,
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.005),
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontFamily: "Manrope",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: subTitle == null
              ? null
              : Text(
                  subTitle!,
                  style: const TextStyle(
                      fontFamily: "manrope",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
            shadows: [
              Shadow(
                  color: Theme.of(context).colorScheme.primary, blurRadius: 8)
            ],
          ),
        ),
      ),
    );
  }
}

//niggas
// ignore: must_be_immutable
class CustomIcons extends StatelessWidget {
  CustomIcons({super.key, required this.icon, this.color});
  Color? color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      foregroundDecoration: BoxDecoration(
          color: color == null
              ? Theme.of(context).colorScheme.secondaryContainer
              : color!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Icon(
        icon,
        size: 27,
        color: color ?? Theme.of(context).colorScheme.primaryFixed,
      ),
    );
  }
}
