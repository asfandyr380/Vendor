class ProductModel {
  int id = 0;
  String? name = '';
  String? price = '0';
  String? salePrice = '0';
  String? description = '';
  String? shortDesc = '';
  String? storeId = '0';
  String? onSale = '0';
  String? status = '0';
  String? cateId = '0';
  String? image = '';
  String? image2 = '';
  String? image3 = '';
  String? image4 = '';
  String? searchKey = '';
  String? attributeStatus = '0';
  String? altTag = '';
  String? metakeywords = '';
  String? metaDesc = '';
  int sold = 0;
  String? vatt = '';

  ProductModel(
      {this.altTag,
      this.attributeStatus,
      this.cateId,
      this.description,
      this.image2,
      this.image,
      this.image3,
      this.image4,
      this.metaDesc,
      this.metakeywords,
      this.name,
      this.onSale,
      this.price,
      this.salePrice,
      this.searchKey,
      this.status,
      this.storeId,
      this.shortDesc,
      this.vatt});

  ProductModel.fromJson(Map map)
      : id = map['id'],
        name = map['name'],
        price = map['price'].toString(),
        salePrice = map['salePrice'].toString(),
        description = map['description'],
        onSale = map['onSale'].toString(),
        status = map['status'].toString(),
        cateId = map['cate_Id'].toString(),
        storeId = map['store_Id'].toString(),
        image = map['image'],
        image2 = map['image2'],
        image3 = map['image3'],
        image4 = map['image4'],
        sold = map['sold'],
        searchKey = map['search_Key'],
        attributeStatus = map['attribute_status'].toString(),
        altTag = map['alt_tag'],
        metakeywords = map['meta_keywords'],
        metaDesc = map['meta_Desc'],
        vatt = map['vatt'];

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "salePrice": salePrice,
        "description": description,
        "store_Id": storeId,
        "onSale": onSale,
        "status": status,
        "cate_Id": cateId,
        "image": image,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "searchKey": searchKey,
        "attribute_status": attributeStatus,
        "alt_tag": altTag,
        "meta_keywords": metakeywords,
        "meta_Desc": metaDesc,
        'shortDesc': shortDesc,
        'vatt': vatt
      };
}

class ProductModel1 {
  int id = 0;
  String? name = '';
  double? price = 0;
  double? salePrice = 0;
  String? description = '';
  String? storename = '';
  int? onSale = 0;
  int? status = 0;
  int? cateId = 0;
  List<String> images;
  List<String> rawImgs;
  String? searchKey = '';
  int? attributeStatus = 0;
  String? altTag = '';
  String? metakeywords = '';
  String? metaDesc = '';
  int sold = 0;
  String subCate = '';
  ProductModel1.fromJson(Map map, List<String> images, List<String> rawPath)
      : id = map['id'],
        name = map['name'],
        price = map['price'],
        salePrice = map['salePrice'],
        description = map['description'],
        onSale = map['onSale'],
        status = map['status'],
        cateId = map['cate_Id'],
        storename = map['store_name'],
        images = images,
        subCate = map['cate_name'],
        sold = map['sold'],
        searchKey = map['search_Key'],
        attributeStatus = map['attribute_status'],
        altTag = map['alt_tag'],
        metakeywords = map['meta_keywords'],
        metaDesc = map['meta_Desc'],
        rawImgs = rawPath;
}
