class User {
  late int id;
  late String username;
  late String email;
  late String name;
  late String state;
  late String avatarUrl;
  late String webUrl;
  late String createdAt;
  late String bio;
  late String location;
  late String publicEmail;
  late String skype;
  late String linkedin;
  late String twitter;
  late String websiteUrl;
  late String organization;
  late String lastSignInAt;
  late String confirmedAt;
  late int themeId;
  late String lastActivityOn;
  late int colorSchemeId;
  late int projectsLimit;
  late String currentSignInAt;
  List<Identities> identities = [];
  late bool canCreateGroup;
  late bool canCreateProject;
  late bool twoFactorEnabled;
  late bool external;
  late bool privateProfile;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.name,
      required this.state,
      required this.avatarUrl,
      required this.webUrl,
      required this.createdAt,
      required this.bio,
      required this.location,
      required this.publicEmail,
      required this.skype,
      required this.linkedin,
      required this.twitter,
      required this.websiteUrl,
      required this.organization,
      required this.lastSignInAt,
      required this.confirmedAt,
      required this.themeId,
      required this.lastActivityOn,
      required this.colorSchemeId,
      required this.projectsLimit,
      required this.currentSignInAt,
      required this.identities,
      required this.canCreateGroup,
      required this.canCreateProject,
      required this.twoFactorEnabled,
      required this.external,
      required this.privateProfile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
    createdAt = json['created_at'];
    bio = json['bio'];
    location = json['location'];
    publicEmail = json['public_email'];
    skype = json['skype'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
    websiteUrl = json['website_url'];
    organization = json['organization'];
    lastSignInAt = json['last_sign_in_at'];
    confirmedAt = json['confirmed_at'];
    themeId = json['theme_id'];
    lastActivityOn = json['last_activity_on'];
    colorSchemeId = json['color_scheme_id'];
    projectsLimit = json['projects_limit'];
    currentSignInAt = json['current_sign_in_at'];
    if (json['identities'] != null) {
      identities = [];
      json['identities'].forEach((v) {
        identities.add(new Identities.fromJson(v));
      });
    }
    canCreateGroup = json['can_create_group'];
    canCreateProject = json['can_create_project'];
    twoFactorEnabled = json['two_factor_enabled'];
    external = json['external'];
    privateProfile = json['private_profile'];
  }

  User.fromJsonInJobs(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
    createdAt = json['created_at'];
    bio = json['bio'];
    location = json['location'];
    publicEmail = json['public_email'];
    skype = json['skype'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
    websiteUrl = json['website_url'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    data['created_at'] = this.createdAt;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['public_email'] = this.publicEmail;
    data['skype'] = this.skype;
    data['linkedin'] = this.linkedin;
    data['twitter'] = this.twitter;
    data['website_url'] = this.websiteUrl;
    data['organization'] = this.organization;
    data['last_sign_in_at'] = this.lastSignInAt;
    data['confirmed_at'] = this.confirmedAt;
    data['theme_id'] = this.themeId;
    data['last_activity_on'] = this.lastActivityOn;
    data['color_scheme_id'] = this.colorSchemeId;
    data['projects_limit'] = this.projectsLimit;
    data['current_sign_in_at'] = this.currentSignInAt;
    if (this.identities != null) {
      data['identities'] = this.identities.map((v) => v.toJson()).toList();
    }
    data['can_create_group'] = this.canCreateGroup;
    data['can_create_project'] = this.canCreateProject;
    data['two_factor_enabled'] = this.twoFactorEnabled;
    data['external'] = this.external;
    data['private_profile'] = this.privateProfile;
    return data;
  }

  Map<String, dynamic> toJsonInJobs() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    data['created_at'] = this.createdAt;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['public_email'] = this.publicEmail;
    data['skype'] = this.skype;
    data['linkedin'] = this.linkedin;
    data['twitter'] = this.twitter;
    data['website_url'] = this.websiteUrl;
    data['organization'] = this.organization;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, name: $name}';
  }
}

class Identities {
  late String provider;
  late String externUid;

  Identities({required this.provider, required this.externUid});

  Identities.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    externUid = json['extern_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['extern_uid'] = this.externUid;
    return data;
  }
}
