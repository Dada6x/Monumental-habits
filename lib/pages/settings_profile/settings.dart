import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            child: SizedBox(
              height: SizeConfig.screenHeight * 0.16,
              child: Stack(
                children: [
                  ListTile(
                    title: Text(
                      "Check Your Profile",
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
                            width: SizeConfig.screenWidth * 0.53,
                            child: const Text(
                              "WardEkhtiar@gmail.com",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "manrope",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        //Color.fromRGBO(240, 222, 250, 0.8)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "View",
                              style: TextStyle(
                                  color: Color(darkPurple),
                                  fontFamily: "klasik",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.025,
                        left: SizeConfig.screenWidth * 0.65),
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
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenHeight * 0.02),
          child: Text(
            "General",
            style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontSize: 16,
                fontFamily: "manrope",
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        SettingsTabs(
            title: "Notifications",
            subTitle: "Customize Notifications",
            leadIcon: Icons.circle_notifications_rounded),
        SettingsTabs(
            title: "More Customization",
            subTitle: "Customize it more to fit your usage",
            leadIcon: Icons.more_horiz),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenHeight * 0.02),
          child: Text(
            "Support",
            style: TextStyle(
                color: Theme.of(context).colorScheme.scrim,
                fontSize: 16,
                fontFamily: "manrope",
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        SettingsTabs(title: "Contact", subTitle: null, leadIcon: Icons.call),
        SettingsTabs(title: "Feedback", subTitle: null, leadIcon: Icons.chat),
        SettingsTabs(
            title: "Privacy Policy", subTitle: null, leadIcon: Icons.shield),
        SettingsTabs(title: "About", subTitle: null, leadIcon: Icons.info),
      ],
    );
  }
}

// ignore: must_be_immutable
class SettingsTabs extends StatelessWidget {
  SettingsTabs({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leadIcon,
    /*required this.TargetPage*/
  });
  final String title;
  String? subTitle;
  final IconData leadIcon;
  //Widget TargetPage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Get.to(() => TargetPage);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          child: Card(
            color: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            child: ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
                    vertical: SizeConfig.screenHeight * 0.005),
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
                      color: Theme.of(context).colorScheme.primary,
                      blurRadius: 8)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//niggas