


class Category {
  String? id;
  String? name;
  String? icon;
  String? status;
  String? created_at;

  Category({this.id, this.name, this.icon, this.status, this.created_at});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'status': status,
      'created_at': created_at,
    };
  }
}