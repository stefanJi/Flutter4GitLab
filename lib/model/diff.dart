class Diff {
  String oldPath;
  String newPath;
  String aMode;
  String bMode;
  bool newFile;
  bool renamedFile;
  bool deletedFile;
  String diff;

  Diff(
      {this.oldPath,
      this.newPath,
      this.aMode,
      this.bMode,
      this.newFile,
      this.renamedFile,
      this.deletedFile,
      this.diff});

  Diff.fromJson(Map<String, dynamic> json) {
    oldPath = json['old_path'];
    newPath = json['new_path'];
    aMode = json['a_mode'];
    bMode = json['b_mode'];
    newFile = json['new_file'];
    renamedFile = json['renamed_file'];
    deletedFile = json['deleted_file'];
    diff = json['diff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_path'] = this.oldPath;
    data['new_path'] = this.newPath;
    data['a_mode'] = this.aMode;
    data['b_mode'] = this.bMode;
    data['new_file'] = this.newFile;
    data['renamed_file'] = this.renamedFile;
    data['deleted_file'] = this.deletedFile;
    data['diff'] = this.diff;
    return data;
  }
}
