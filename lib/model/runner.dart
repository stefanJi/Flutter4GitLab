class Runner {
  late bool active;
  late String description;
  late int id;
  late bool isShared;
  late String ipAddress;
  late String name;
  late bool online;
  late String status;

  Runner(
      {required this.active,
      required this.description,
      required this.id,
      required this.isShared,
      required this.ipAddress,
      required this.name,
      required this.online,
      required this.status});

  Runner.fromJson(Map<String, dynamic> json) {
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
