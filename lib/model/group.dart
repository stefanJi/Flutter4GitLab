
class Group {
  int id;
  String name;
  String path;
  String description;
  String visibility;
  bool lfsEnabled;
  String avatarUrl;
  String webUrl;
  bool requestAccessEnabled;
  String fullName;
  String fullPath;
  int fileTemplateProjectId;
  int parentId;

  Group(
      {this.id,
        this.name,
        this.path,
        this.description,
        this.visibility,
        this.lfsEnabled,
        this.avatarUrl,
        this.webUrl,
        this.requestAccessEnabled,
        this.fullName,
        this.fullPath,
        this.fileTemplateProjectId,
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
    fileTemplateProjectId = json['file_template_project_id'];
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
    data['file_template_project_id'] = this.fileTemplateProjectId;
    data['parent_id'] = this.parentId;
    return data;
  }
}
