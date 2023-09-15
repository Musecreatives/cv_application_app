import 'package:flutter/material.dart';
import 'package:cv_application/screens/home_screen.dart';
import 'package:cv_application/src/common_widgets/foms_widget.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import 'package:cv_application/src/db/cv_database.dart' as db;
import 'package:cv_application/src/model/form.dart' as model;

import '../src/constants/sizes.dart';

class EditScreen extends StatefulWidget {
  final model.Form? form;

  const EditScreen({super.key, this.form});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late String fullName;
  late String slackUserName;
  late String githubUserName;
  late String bio;

  @override
  void initState() {
    super.initState();

    isImportant = widget.form?.isImportant ?? false;
    fullName = widget.form?.fullName ?? '';
    slackUserName = widget.form?.slackUserName ?? '';
    githubUserName = widget.form?.githubUserName ?? '';
    bio = widget.form?.bio ?? '';
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
          key: _formKey,
          child: ProfileForm(
            isImportant: isImportant,
            fullName: fullName,
            slackUserName: slackUserName,
            githubUserName: githubUserName,
            bio: bio,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedFullName: (fullName) =>
                setState(() => this.fullName = fullName),
            onChangedSlackUserName: (slackUserName) =>
                setState(() => this.slackUserName = slackUserName),
            onChangedGithubUserName: (githubUserName) =>
                setState(() => this.githubUserName = githubUserName),
            onChangedBio: (bio) => setState(() => this.bio = bio),
            onSavedForm: addOrUpdateForm,
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = fullName.isNotEmpty &&
        slackUserName.isNotEmpty &&
        githubUserName.isNotEmpty &&
        bio.isNotEmpty;

    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, tFormHeight),
            backgroundColor: isFormValid ? Colors.black : Colors.redAccent,
          ),
          onPressed: addOrUpdateForm,
          child: const Text('Edit CV'),
        ));
  }

  void addOrUpdateForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.form != null;

      if (isUpdating) {
        await updateForm();
      } else {
        await addForm();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateForm() async {
    final form = widget.form!.copy(
      fullName: fullName,
      slackUserName: slackUserName,
      githubUserName: githubUserName,
      bio: bio,
    );

    await db.CvDatabase.instance.update(form);
  }

  Future addForm() async {
    final form = model.Form(
      fullName: fullName,
      slackUserName: slackUserName,
      githubUserName: githubUserName,
      bio: bio,
      isImportant: isImportant,
      createdAt: DateTime.now(),
      id: null,
    );

    await db.CvDatabase.instance.create(form);
  }
}
