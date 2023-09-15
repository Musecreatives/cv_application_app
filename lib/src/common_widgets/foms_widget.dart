import 'package:cv_application/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

import 'package:cv_application/src/db/cv_database.dart' as db;
import '../model/form.dart' as model;

class ProfileForm extends StatefulWidget {
  final model.Form? form;
  final bool? isImportant;
  final String? fullName;
  final String? slackUserName;
  final String? githubUserName;
  final String? bio;
  final ValueChanged<bool>? onChangedImportant;
  final ValueChanged<String>? onChangedFullName;
  final ValueChanged<String>? onChangedSlackUserName;
  final ValueChanged<String>? onChangedGithubUserName;
  final ValueChanged<String>? onChangedBio;
  final VoidCallback? onSavedForm;

  const ProfileForm(
      {Key? key, 
      this.isImportant,
      this.fullName,
      this.slackUserName,
      this.githubUserName,
      this.bio,
      this.onChangedImportant,
      this.onChangedFullName,
      this.onChangedSlackUserName,
      this.onChangedGithubUserName,
      this.onChangedBio,
      this.onSavedForm, this.form})
      : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
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
    return Form(
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
                                image: AssetImage('assets/images/profile.png'),
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
                    buildName(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildUsername(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildGithubUsername(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildBio(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildButton(),
                    /* -- Form -- */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = widget.fullName!.isNotEmpty &&
        widget.slackUserName!.isNotEmpty &&
        widget.githubUserName!.isNotEmpty &&
        widget.bio!.isNotEmpty;

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

      Navigator.of(context).pop('HomeScree');
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
      createdAt: DateTime.now(), id: null,
    );

    await db.CvDatabase.instance.create(form);
  }

  Widget buildName() => TextFormField(
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
        onChanged: widget.onChangedFullName,
      );

  Widget buildUsername() => TextFormField(
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
        onChanged: widget.onChangedSlackUserName,
      );

  Widget buildGithubUsername() => TextFormField(
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
        onChanged: widget.onChangedGithubUserName,
      );

  Widget buildBio() => TextFormField(
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Profile Bio',
          prefixIcon: Icon(LineAwesomeIcons.info_circle),
          hintText: 'Enter your profile bio',
          border: OutlineInputBorder(),
        ),
        validator: (bio) =>
            bio != null && bio.isEmpty ? 'The field cannot be empty' : null,
        onChanged: widget.onChangedBio,
      );
}
