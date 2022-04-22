

import 'dart:convert';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Dashboard.dart';

/*class Category {
  int? id;
  String? name;
  String? icon;
  String? status;
  String? created_at;
  static String encodedData="";

  Category({this.id, this.name, this.icon, this.status, this.created_at});

  Category.fromJson(Map<String, dynamic> json)  {
    name = json['name'];
    icon = json['mobile_icon'];
    id = json['id'];
    status = json['display'];
    created_at = json['created_at'];
    encodedData = "";
    // DashBoard.subcatList = <SubCategory>[];
    // DashBoard.subcatListFilter = <SubCategory>[];
    //
    // List<SubCategory> _subcategory_list = <SubCategory>[];
    // for (var item in convert.jsonDecode(json['children'])) {
    //   {
    //     _subcategory_list.add(SubCategory.fromJson(item));
    //     DashBoard.subcatList.add(SubCategory.fromJson(item));
    //     encodedData = SubCategory.encode([SubCategory.fromJson(item)]);
    //   }
    // }

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': name,
      'mobile_icon': icon,
      'display': status,
      'created_at': created_at,
    };
  }
}
class SubCategory {
  String? cat_id;
  String? id;
  String? name;
  String? mobile_icon;
  String? category_name;

  SubCategory({required this.id, required this.cat_id, required this.name, required this.mobile_icon, required this.category_name});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cat_id = json['parent_id'];
    name = json['name'];
    mobile_icon = json['mobile_icon'];
    category_name = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': cat_id,
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
}*/


class Category {
  int? id;
  String? name;
  String? slug;
  String? product;
  String? parentId;
  String? haveChild;
  String? iconClass;
  Null? mobileIcon;
  String? sortBy;
  String? countryId;
  String? display;
  Null? createdAt;
  Null? updatedAt;
  List<SubCategory> children=<SubCategory>[];

  Category(
      {this.id,
        this.name,
        this.slug,
        this.product,
        this.parentId,
        this.haveChild,
        this.iconClass,
        this.mobileIcon,
        this.sortBy,
        this.countryId,
        this.display,
        this.createdAt,
        this.updatedAt,
        required this.children});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    product = json['product'];
    parentId = json['parent_id'];
    haveChild = json['have_child'];
    iconClass = json['icon_class'];
    mobileIcon = json['mobile_icon'];
    sortBy = json['sort_by'];
    countryId = json['country_id'];
    display = json['display'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <SubCategory>[];
      json['children'].forEach((v) {
        children.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product'] = this.product;
    data['parent_id'] = this.parentId;
    data['have_child'] = this.haveChild;
    data['icon_class'] = this.iconClass;
    data['mobile_icon'] = this.mobileIcon;
    data['sort_by'] = this.sortBy;
    data['country_id'] = this.countryId;
    data['display'] = this.display;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int? id;
  String? name;
  String? slug;
  String? product;
  String? parentId;
  String? haveChild;
  String? iconClass;
  String? mobileIcon;
  String? sortBy;
  String? countryId;
  String? display;
  String? createdAt;
  String? updatedAt;
  // List<Null>? children;

  SubCategory(
      {this.id,
        this.name,
        this.slug,
        this.product,
        this.parentId,
        this.haveChild,
        this.iconClass,
        this.mobileIcon,
        this.sortBy,
        this.countryId,
        this.display,
        this.createdAt,
        this.updatedAt,
        /*this.children*/});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    product = json['product'];
    parentId = json['parent_id'];
    haveChild = json['have_child'];
    iconClass = json['icon_class'];
    mobileIcon = json['mobile_icon'];
    sortBy = json['sort_by'];
    countryId = json['country_id'];
    display = json['display'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['children'] != null) {
    //   children = <Null>[];
    //   json['children'].forEach((v) {
    //     children!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product'] = this.product;
    data['parent_id'] = this.parentId;
    data['have_child'] = this.haveChild;
    data['icon_class'] = this.iconClass;
    data['mobile_icon'] = this.mobileIcon;
    data['sort_by'] = this.sortBy;
    data['country_id'] = this.countryId;
    data['display'] = this.display;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.children != null) {
    //   data['children'] = this.children!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
  static String encode(List<SubCategory> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => SubCategory.toMap(music))
        .toList(),
  );

  static List<SubCategory> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<SubCategory>((item) => SubCategory.fromJson(item))
          .toList();


  static Map<String, dynamic> toMap(SubCategory subCategory) => {
  'id':subCategory.id,
  'name':subCategory.name,
  'slug':subCategory.slug,
  'product':subCategory.product,
  'parent_id':subCategory.parentId,
  'have_child':subCategory.haveChild,
  'icon_class':subCategory.iconClass,
  'mobile_icon':subCategory.mobileIcon,
  'sort_by':subCategory.sortBy,
  'country_id':subCategory.countryId,
  'display':subCategory.display,
  'created_at':subCategory.createdAt,
  'updated_at':subCategory.updatedAt,
  };
}

