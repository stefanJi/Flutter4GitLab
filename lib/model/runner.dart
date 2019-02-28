class Runner {
  bool active;
  String description;
  int id;
  bool isShared;
  String ipAddress;
  String name;
  bool online;
  String status;

  Runner(
      {this.active,
      this.description,
      this.id,
      this.isShared,
      this.ipAddress,
      this.name,
      this.online,
      this.status});

  Runner.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    active = json['active'];
    description = json['description'];
    id = json['id'];
    isShared = json['is_shared'];
    ipAddress = json['ip_address'];
    name = json['name'];
    online = json['online'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['description'] = this.description;
    data['id'] = this.id;
    data['is_shared'] = this.isShared;
    data['ip_address'] = this.ipAddress;
    data['name'] = this.name;
    data['online'] = this.online;
    data['status'] = this.status;
    return data;
  }
}
