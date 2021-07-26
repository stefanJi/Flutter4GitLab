class Group {
  late int id;
  late String name;
  late String path;
  late String description;
  late String visibility;
  late bool lfsEnabled;
  String? avatarUrl;
  late String webUrl;
  late bool requestAccessEnabled;
  late String fullName;
  late String fullPath;
  int? parentId;

  Group(
      {required this.id,
      required this.name,
      required this.path,
      required this.description,
      required this.visibility,
      required this.lfsEnabled,
      this.avatarUrl,
      required this.webUrl,
      required this.requestAccessEnabled,
      required this.fullName,
      required this.fullPath,
      this.parentId});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    description = json['description'];
    visibility = json['visibility'];
    lfsEnabled = json['lfs_enabled'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
    requestAccessEnabled = json['request_access_enabled'];
    fullName = json['full_name'];
    fullPath = json['full_path'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['path'] = this.path;
    data['description'] = this.description;
    data['visibility'] = this.visibility;
    data['lfs_enabled'] = this.lfsEnabled;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    data['request_access_enabled'] = this.requestAccessEnabled;
    data['full_name'] = this.fullName;
    data['full_path'] = this.fullPath;
    data['parent_id'] = this.parentId;
    return data;
  }
}
