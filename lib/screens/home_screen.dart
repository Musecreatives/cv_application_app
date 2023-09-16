import 'package:cv_application/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import '../src/db/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Data profileData = Data();
  bool isLoading = false;

  void refreshHomeScreen({
    String? fullName,
    String? slackUserName,
    String? bioSummary,
    String? githubUserName,
  }) {
    setState(() {
      profileData.fullName = fullName!;
      profileData.slackUserName = slackUserName!;
      profileData.bioSummary = bioSummary!;
      profileData.githubUserName = githubUserName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(right: 140.0),
          child: Text(
            'Curriculum Vitae',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditScreen(updateProfilescreen: refreshHomeScreen,)),
                );
              },
              icon: const Icon(
                LineAwesomeIcons.edit,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
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
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileData.fullName,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                profileData.slackUserName,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    LineAwesomeIcons.github,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    profileData.githubUserName,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    profileData.bioSummary,
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Skills',
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Flutter',
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 76, 59, 59),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'JavaScript',
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Dart',
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'C/C++',
                            style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        hoverColor: Colors.blue,
        focusColor: Colors.black,
        onPressed: () {
          // Navigate to the editing screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditScreen(updateProfilescreen: refreshHomeScreen,)),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}