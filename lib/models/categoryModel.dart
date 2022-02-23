

import 'dart:convert';

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
class SubCategory {
  String? cat_id;
  String? name;
  String? mobile_icon;
  String? category_name;

  SubCategory({required this.cat_id, required this.name, required this.mobile_icon, required this.category_name});

  SubCategory.fromJson(Map<String, dynamic> json) {
    cat_id = json['cat_id'];
    name = json['name'];
    mobile_icon = json['mobile_icon'];
    category_name = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': cat_id,
      'name': name,
      'mobile_icon': mobile_icon,
      'category_name': category_name
    };
  }

  static Map<String, dynamic> toMap(SubCategory subCategory) => {
    'id': subCategory.cat_id,
    'name': subCategory.name,
    'mobile_icon': subCategory.mobile_icon,
    'category_name': subCategory.category_name,

  };
  static String encode(List<SubCategory> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => SubCategory.toMap(music))
        .toList(),
  );

  static List<SubCategory> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<SubCategory>((item) => SubCategory.fromJson(item))
          .toList();
}

