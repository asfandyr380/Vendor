class AttributeModel {
  String? stock = '0';
  String? variant = '';
  String? price = '0';
  String? image = '';
  String? productId = '0';

  AttributeModel(
      {this.productId, this.image, this.price, this.stock, this.variant});

  AttributeModel.fromJson(int stock, String variant, double price,
      {int? id, String? img})
      : this.stock = stock.toString(),
        this.variant = variant,
        this.price = price.toString(),
        this.productId = id.toString(),
        this.image = img;

  Map<String, dynamic> toJson() => {
        "stock": stock,
        "variant": variant,
        "price": price,
        "image": image,
        "productId": productId,
        "salePrice": '0'
      };
}
