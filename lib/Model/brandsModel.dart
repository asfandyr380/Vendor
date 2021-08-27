class Brand {
  int? id = 0;
  String? name = '';

  Brand.fromMap(Map map)
      : id = map['id'],
        name = map['brandName'];
}
