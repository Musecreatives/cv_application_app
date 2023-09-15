import 'package:cv_application/screens/edit_screen.dart';
import 'package:cv_application/src/db/cv_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import '../src/common_widgets/profile_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late List<Form> form;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshForms();
  }

  @override
  void dispose() {
    CvDatabase.instance.close();

    super.dispose();
  }

  Future refreshForms() async {
    setState(() => isLoading = true);

    form = (await CvDatabase.instance.readAllForms()).cast<Form>();

    setState(() => isLoading = false);
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
                  MaterialPageRoute(builder: (context) => const EditScreen()),
                );
              },
              icon: const Icon(
                LineAwesomeIcons.edit,
                color: Colors.white,
              )),
        ],
      ),
      body: Container(
        child: isLoading ? const CircularProgressIndicator() : form.isEmpty ? Text(
          'No Profile Information',
          style: GoogleFonts.montserrat(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black)
        ) : ListView.builder(
          itemCount: form.length,
          itemBuilder: (BuildContext context, int index) {

            return ProfileCardWidget(
              form: form[index],
              key: UniqueKey(),);
          },
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
            MaterialPageRoute(builder: (context) => const EditScreen()),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

   
