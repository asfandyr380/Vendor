class GeneralCate {
  int? cateId = 0;
  String? name = '';

  GeneralCate.fromJson(Map map)
      : cateId = map['cate_Id'],
        this.name = map['cate_name'];
}

class SuperCate {
  int? superId = 0;
  int? cateId = 0;
  String name = '';

  SuperCate.fromMap(Map map)
      : superId = map['superCate_Id'],
        cateId = map['cate_Id'],
        name = map['name'];
}

class SubCate {
  int? subId = 0;
  int? superId = 0;
  String name = '';

  SubCate.fromJson(Map map)
      : subId = map['subCate_Id'],
        superId = map['superCate_Id'],
        name = map['name'];
}

class CategoryModel {
  String generalCate = '';
  String? superCate = '';
  String? subCate = '';

  CategoryModel({required this.generalCate, this.subCate, this.superCate});

  Map<String, dynamic> toJson() => {
        "generalCate": generalCate,
        "superCate": superCate ?? '',
        "subCate": subCate ?? 'null'
      };
}
