import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String email;
  String name;
  String state;
  String avatar_url;
  String web_url;
  String created_at;
  String bio;
  String location;
  String public_email;
  String skype;
  String linkedin;
  String twitter;
  String website_url;
  String organization;
  String last_sign_in_at;
  String confirmed_at;
  String theme_id;
  String last_activity_on;
  String color_scheme_id;
  String projects_limit;
  String current_sign_in_at;
  String identities;
  String can_create_group;
  String can_create_project;
  String two_factor_enabled;
  String external;
  String private_profile;

  User({
    this.id,
    this.username,
    this.email,
    this.name,
    this.state,
    this.avatar_url,
    this.web_url,
    this.created_at,
    this.bio,
    this.location,
    this.public_email,
    this.skype,
    this.linkedin,
    this.twitter,
    this.website_url,
    this.organization,
    this.last_sign_in_at,
    this.confirmed_at,
    this.theme_id,
    this.last_activity_on,
    this.color_scheme_id,
    this.projects_limit,
    this.current_sign_in_at,
    this.identities,
    this.can_create_group,
    this.can_create_project,
    this.two_factor_enabled,
    this.external,
    this.private_profile,
  });
}
