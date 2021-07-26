class Project {
  late int id;
  late String description;
  late String defaultBranch;
  late String sshUrlToRepo;
  late String httpUrlToRepo;
  late String webUrl;
  String? readmeUrl;
  late List<String> tagList;
  late String name;
  late String nameWithNamespace;
  late String path;
  late String pathWithNamespace;
  late String createdAt;
  late String lastActivityAt;
  late int forksCount;
  String? avatarUrl;
  late int starCount;

  Project(
      {required this.id,
      required this.description,
      required this.defaultBranch,
      required this.sshUrlToRepo,
      required this.httpUrlToRepo,
      required this.webUrl,
      this.readmeUrl,
      required this.tagList,
      required this.name,
      required this.nameWithNamespace,
      required this.path,
      required this.pathWithNamespace,
      required this.createdAt,
      required this.lastActivityAt,
      required this.forksCount,
      this.avatarUrl,
      required this.starCount});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    defaultBranch = json['default_branch'];
    sshUrlToRepo = json['ssh_url_to_repo'];
    httpUrlToRepo = json['http_url_to_repo'];
    webUrl = json['web_url'];
    readmeUrl = json['readme_url'];
    tagList = json['tag_list'].cast<String>();
    name = json['name'];
    nameWithNamespace = json['name_with_namespace'];
    path = json['path'];
    pathWithNamespace = json['path_with_namespace'];
    createdAt = json['created_at'];
    lastActivityAt = json['last_activity_at'];
    forksCount = json['forks_count'];
    avatarUrl = json['avatar_url'];
    starCount = json['star_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['default_branch'] = this.defaultBranch;
    data['ssh_url_to_repo'] = this.sshUrlToRepo;
    data['http_url_to_repo'] = this.httpUrlToRepo;
    data['web_url'] = this.webUrl;
    data['readme_url'] = this.readmeUrl;
    data['tag_list'] = this.tagList;
    data['name'] = this.name;
    data['name_with_namespace'] = this.nameWithNamespace;
    data['path'] = this.path;
    data['path_with_namespace'] = this.pathWithNamespace;
    data['created_at'] = this.createdAt;
    data['last_activity_at'] = this.lastActivityAt;
    data['forks_count'] = this.forksCount;
    data['avatar_url'] = this.avatarUrl;
    data['star_count'] = this.starCount;
    return data;
  }
}
