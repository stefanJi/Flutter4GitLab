// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      state: json['state'] as String,
      avatar_url: json['avatar_url'] as String,
      web_url: json['web_url'] as String,
      created_at: json['created_at'] as String,
      bio: json['bio'] as String,
      location: json['location'] as String,
      public_email: json['public_email'] as String,
      skype: json['skype'] as String,
      linkedin: json['linkedin'] as String,
      twitter: json['twitter'] as String,
      website_url: json['website_url'] as String,
      organization: json['organization'] as String,
      last_sign_in_at: json['last_sign_in_at'] as String,
      confirmed_at: json['confirmed_at'] as String,
      theme_id: json['theme_id'] as String,
      last_activity_on: json['last_activity_on'] as String,
      color_scheme_id: json['color_scheme_id'] as String,
      projects_limit: json['projects_limit'] as String,
      current_sign_in_at: json['current_sign_in_at'] as String,
      identities: json['identities'] as String,
      can_create_group: json['can_create_group'] as String,
      can_create_project: json['can_create_project'] as String,
      two_factor_enabled: json['two_factor_enabled'] as String,
      external: json['external'] as String,
      private_profile: json['private_profile'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'state': instance.state,
      'avatar_url': instance.avatar_url,
      'web_url': instance.web_url,
      'created_at': instance.created_at,
      'bio': instance.bio,
      'location': instance.location,
      'public_email': instance.public_email,
      'skype': instance.skype,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'website_url': instance.website_url,
      'organization': instance.organization,
      'last_sign_in_at': instance.last_sign_in_at,
      'confirmed_at': instance.confirmed_at,
      'theme_id': instance.theme_id,
      'last_activity_on': instance.last_activity_on,
      'color_scheme_id': instance.color_scheme_id,
      'projects_limit': instance.projects_limit,
      'current_sign_in_at': instance.current_sign_in_at,
      'identities': instance.identities,
      'can_create_group': instance.can_create_group,
      'can_create_project': instance.can_create_project,
      'two_factor_enabled': instance.two_factor_enabled,
      'external': instance.external,
      'private_profile': instance.private_profile
    };
