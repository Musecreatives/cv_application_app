import 'package:flutter/material.dart';
import 'package:cv_application/screens/home_screen.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import '../src/constants/sizes.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.updateProfilescreen}) : super(key: key);
  final Function updateProfilescreen;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool missingFields = false;
  bool isLoading = false;
  late bool isImportant;
  late String fullName;
  late String slackUserName;
  late String githubUserName;
  late String bioSummary;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController slackUserNameController = TextEditingController();
  TextEditingController githubUserNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    slackUserNameController.dispose();
    githubUserNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomeScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
          title: const Text('Edit CV'),
        ),
        body: Form(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: tFormHeight - 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        /* Profile Image*/
                        Stack(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image:
                                        AssetImage('assets/images/profile.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(
                                  LineAwesomeIcons.camera,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        /* Profile Image end*/
                        const SizedBox(
                          height: 20,
                        ),
                        /* -- Form -- */
                        buildName(
                            context: context, controller: fullNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        buildUsername(
                            context: context,
                            controller: slackUserNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        buildGithubUsername(
                            context: context,
                            controller: githubUserNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        buildBio(context: context, controller: bioController),
                        const SizedBox(
                          height: 20,
                        ),
                        /* -- Form -- */
                        buildButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return InkWell(
      onTap: () {
        if (fullNameController.text.isNotEmpty &&
            slackUserNameController.text.isNotEmpty &&
            githubUserNameController.text.isNotEmpty &&
            bioController.text.isNotEmpty) {
          setState(() {
            isLoading = true;

            widget.updateProfilescreen(
              fullName: fullNameController.text,
              slackUserName: slackUserNameController.text,
              githubUserName: githubUserNameController.text,
              bioSummary: bioController.text,
            );

            Navigator.pop(context);
          });
        } else {
          setState(() {
            missingFields = true;
          });
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, tFormHeight),
            backgroundColor: Colors.black,
          ),
          onPressed: () {},
          child: const Text('Save'),
        ),
      ),
    );
  }

  Widget buildName(
      {required BuildContext context,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'Full Name',
        prefixIcon: Icon(Icons.person_outline_outlined),
        hintText: 'Enter your full name',
        border: OutlineInputBorder(),
      ),
      validator: (fullName) => fullName != null && fullName.isEmpty
          ? 'The field cannot be empty'
          : null,
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget buildUsername(
      {required BuildContext context,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'Slack Username',
        prefixIcon: Icon(LineAwesomeIcons.slack),
        hintText: 'paul',
        border: OutlineInputBorder(),
      ),
      validator: (slackUserName) =>
          slackUserName != null && slackUserName.isEmpty
              ? 'The field cannot be empty'
              : null,
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget buildGithubUsername(
      {required BuildContext context,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'GitHub Username',
        prefixIcon: Icon(LineAwesomeIcons.github_alt),
        hintText: 'paul',
        border: OutlineInputBorder(),
      ),
      validator: (githubUserName) =>
          githubUserName != null && githubUserName.isEmpty
              ? 'The field cannot be empty'
              : null,
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget buildBio(
      {required BuildContext context,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Profile Bio',
        prefixIcon: Icon(LineAwesomeIcons.info_circle),
        hintText: 'Enter your profile bio',
        border: OutlineInputBorder(),
      ),
      validator: (bio) =>
          bio != null && bio.isEmpty ? 'The field cannot be empty' : null,
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
