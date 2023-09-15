const String tableFormFields = 'formFields';

class FormFields {
  static final List<String> values = [
    id,
    fullName,
    slackUserName,
    githubUserName,
    isImportant,
    bio,
    createdAt,
  ];
  static const String id = '_id';
  static const String fullName = 'fullName';
  static const String slackUserName = 'slackUserName';
  static const String githubUserName = 'githubUserName';
  static const String isImportant = 'isImportant';
  static const String bio = 'bio';
  static const String createdAt = 'createdAt';
}

class Form {
  final String fullName;
  final String? slackUserName;
  final String? githubUserName;
  final int? id;
  final bool isImportant;
  final String? bio;
  final DateTime? createdAt;

    const Form({
    this.id,
    required this.isImportant,
    required this.bio,
    required this.fullName,
    required this.githubUserName,
    required this.createdAt,
    required this.slackUserName,
  });

  formItems() {
    return [
      fullName,
      slackUserName,
      githubUserName,
      bio,
    ];
  }

  Form copy({
    int? id,
    String? fullName,
    String? slackUserName,
    String? githubUserName,
    bool? isImportant,
    String? bio,
    DateTime? createdAt,
  }) =>
      Form(
        createdAt: createdAt ?? this.createdAt,
        fullName: fullName ?? this.fullName,
        githubUserName: githubUserName ?? this.githubUserName,
        slackUserName: slackUserName ?? this.slackUserName,
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        bio: bio ?? this.bio,
      );

  static Form fromJson(Map<String, dynamic> json) => Form(
        createdAt: DateTime.parse(json[FormFields.createdAt]),
        fullName: json[FormFields.fullName],
        githubUserName: json[FormFields.githubUserName],
        slackUserName: json[FormFields.slackUserName],
        id: json[FormFields.id],
        isImportant: json[FormFields.isImportant] == 1,
        bio: json[FormFields.bio],
      );

  Map<String, dynamic> toJson() => {
        FormFields.id: id,
        FormFields.fullName: fullName,
        FormFields.slackUserName: slackUserName,
        FormFields.githubUserName: githubUserName,
        FormFields.isImportant: isImportant ? 1 : 0,
        FormFields.bio: bio,
        FormFields.createdAt: createdAt!.toIso8601String(),
      };
}
