class Discussion {
  String id;
  bool individualNote;
  List<Notes> notes;

  Discussion({this.id, this.individualNote, this.notes});

  Discussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    individualNote = json['individual_note'];
    if (json['notes'] != null) {
      notes = new List<Notes>();
      json['notes'].forEach((v) {
        notes.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['individual_note'] = this.individualNote;
    if (this.notes != null) {
      data['notes'] = this.notes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  int id;
  String type;
  String body;
  String attachment;
  Author author;
  String createdAt;
  String updatedAt;
  bool system;
  int noteableId;
  String noteableType;
  int noteableIid;
  bool resolved;
  bool resolvable;
  Author resolvedBy;

  Notes(
      {this.id,
      this.type,
      this.body,
      this.attachment,
      this.author,
      this.createdAt,
      this.updatedAt,
      this.system,
      this.noteableId,
      this.noteableType,
      this.noteableIid,
      this.resolved,
      this.resolvable,
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
      data['author'] = this.author.toJson();
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
  int id;
  String name;
  String username;
  String state;
  String avatarUrl;
  String webUrl;

  Author(
      {this.id,
      this.name,
      this.username,
      this.state,
      this.avatarUrl,
      this.webUrl});

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
