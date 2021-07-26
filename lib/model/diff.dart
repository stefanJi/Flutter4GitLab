class Diff {
  late String oldPath;
  late String newPath;
  late String aMode;
  late String bMode;
  late bool newFile;
  late bool renamedFile;
  late bool deletedFile;
  late String diff;

  Diff(
      {required this.oldPath,
      required this.newPath,
      required this.aMode,
      required this.bMode,
      required this.newFile,
      required this.renamedFile,
      required this.deletedFile,
      required this.diff});

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
