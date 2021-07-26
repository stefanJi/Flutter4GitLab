class Discussion {
  late String id;
  late bool individualNote;
  late List<Notes> notes = [];

  Discussion(
      {required this.id, required this.individualNote, required this.notes});

  Discussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    individualNote = json['individual_note'];
    if (json['notes'] != null) {
      notes = [];
      json['notes'].forEach((v) {
        notes.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['individual_note'] = this.individualNote;
    data['notes'] = this.notes.map((v) => v.toJson()).toList();
    return data;
  }
}

class Notes {
  late int id;
  late String type;
  late String body;
  late String attachment;
  Author? author;
  late String createdAt;
  late String updatedAt;
  late bool system;
  late int noteableId;
  late String noteableType;
  late int noteableIid;
  late bool resolved;
  late bool resolvable;
  Author? resolvedBy;

  Notes(
      {required this.id,
      required this.type,
      required this.body,
      required this.attachment,
      this.author,
      required this.createdAt,
      required this.updatedAt,
      required this.system,
      required this.noteableId,
      required this.noteableType,
      required this.noteableIid,
      required this.resolved,
      required this.resolvable,
      this.resolvedBy});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    body = json['body'];
    attachment = json['attachment'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    system = json['system'];
    noteableId = json['noteable_id'];
    noteableType = json['noteable_type'];
    noteableIid = json['noteable_iid'];
    resolved = json['resolved'] != null ? json['resolved'] : false;
    resolvable = json['resolvable'];
    resolvedBy = json['resolved_by'] != null
        ? new Author.fromJson(json['author'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['body'] = this.body;
    data['attachment'] = this.attachment;
    if (this.author != null) {
      data['author'] = this.author?.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['system'] = this.system;
    data['noteable_id'] = this.noteableId;
    data['noteable_type'] = this.noteableType;
    data['noteable_iid'] = this.noteableIid;
    data['resolved'] = this.resolved;
    data['resolvable'] = this.resolvable;
    data['resolved_by'] = this.resolvedBy;
    return data;
  }
}

class Author {
  late int id;
  late String name;
  late String username;
  late String state;
  late String avatarUrl;
  late String webUrl;

  Author(
      {required this.id,
      required this.name,
      required this.username,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    return data;
  }
}
