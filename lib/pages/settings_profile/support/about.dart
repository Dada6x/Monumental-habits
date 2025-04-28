import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/customappBar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar([], "About Us".tr, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.asset(
                  "assets/images/tent.png",
                  // width: MediaQuery.sizeOf(context).width * 0.5,
                  // height: MediaQuery.sizeOf(context).height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("------------  Features ------------ ".tr,
                  style: headerStyle(context)),
              Features(
                title: "Habits".tr,
                subtitle:
                    "Add and track your habits with scheduled days and specific times to practice them."
                        .tr
                        .tr,
              ),
              Features(
                  title: "RoadMaps".tr,
                  subtitle:
                      "Choose personalized pathways to achieve your goals, tailored to different lifestyles and aspirations."
                          .tr),
              Features(
                  title: "Community".tr,
                  subtitle:
                      "Connect with fellow users in a dedicated chat space to share progress, tips, and motivation."
                          .tr),
              Text("-------------  Team  ------------- ".tr,
                  style: headerStyle(context)),
              const ProfileTab(
                name: "Ward Ekhtiar",
                role: "flutter Developer ",
              ),
              const ProfileTab(
                name: "Yahea Dada",
                role: "flutter Developer ",
              ),
              const ProfileTab(
                name: "Abd Alrzaq Najeeb ",
                role: "php Developer ",
              ),
              Text("------------  Purpose  ------------".tr,
                  style: headerStyle(context)),
              Text(
                "By providing a simple yet effective habit tracker, we aim to inspire consistent progress, foster growth, and help users turn small actions into meaningful results. Every journey begins with a single step, and we're here to support you every step of the way."
                    .tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: 14,
                    fontFamily: "manrope",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Get.isDarkMode
                ? const Color(lavander)
                : const Color(darkPurple),
            fontSize: 20,
            fontFamily: "klasik"),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontFamily: "manrope",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.scrim),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key, required this.name, required this.role});
  final String name;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.tertiary,
          child: ListTile(
            onLongPress: () {},
            leading: const CircleAvatar(
              foregroundImage: AssetImage("assets/images/tent.png"),
              radius: 25,
            ),
            title: Text(
              name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily: "manrope",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              role,
              style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "manrope",
                  fontSize: 13,
                  fontWeight: FontWeight.w800),
            ),
            trailing: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
