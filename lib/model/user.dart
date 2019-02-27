class User {
  int id;
  String username;
  String email;
  String name;
  String state;
  String avatarUrl;
  String webUrl;
  String createdAt;
  String bio;
  String location;
  String publicEmail;
  String skype;
  String linkedin;
  String twitter;
  String websiteUrl;
  String organization;
  String lastSignInAt;
  String confirmedAt;
  int themeId;
  String lastActivityOn;
  int colorSchemeId;
  int projectsLimit;
  String currentSignInAt;
  List<Identities> identities;
  bool canCreateGroup;
  bool canCreateProject;
  bool twoFactorEnabled;
  bool external;
  bool privateProfile;

  User(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.state,
      this.avatarUrl,
      this.webUrl,
      this.createdAt,
      this.bio,
      this.location,
      this.publicEmail,
      this.skype,
      this.linkedin,
      this.twitter,
      this.websiteUrl,
      this.organization,
      this.lastSignInAt,
      this.confirmedAt,
      this.themeId,
      this.lastActivityOn,
      this.colorSchemeId,
      this.projectsLimit,
      this.currentSignInAt,
      this.identities,
      this.canCreateGroup,
      this.canCreateProject,
      this.twoFactorEnabled,
      this.external,
      this.privateProfile});

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
      identities = new List<Identities>();
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
}

class Identities {
  String provider;
  String externUid;

  Identities({this.provider, this.externUid});

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
