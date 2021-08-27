class StoreModel {
  int? storeId = 0;
  int? status = 0;
  String? name = '';
  String? ownerName = '';
  String? email = '';
  String? phone = '';
  String? postalCode = '';
  String? logo = '';
  String? description = '';
  String? address = '';

  StoreModel(
      {this.address,
      this.description,
      this.email,
      this.logo,
      this.name,
      this.ownerName,
      this.phone,
      this.postalCode,
      this.status,
      this.storeId});

  StoreModel.fromJson(Map map, String img)
      : storeId = map['store_Id'],
        status = map['store_status'],
        name = map['store_name'],
        ownerName = map['owner_name'],
        email = map['email'],
        phone = map['phone'],
        postalCode = map['postal_code'],
        description = map['store_description'],
        logo = img,
        address = map['address'];

  Map<String, dynamic> toJson({String? password}) => {
        'store_name': name,
        'owner_name': ownerName,
        'email': email,
        'phone': phone,
        'desc': description,
        'logo': logo,
        'postal_code': postalCode,
        'address': address,
        'password': password,
      };

  Map<String, dynamic> toJsonWithoutLogo({String? password}) => {
        'name': name,
        'owner_name': ownerName,
        'email': email,
        'phone': phone,
        'desc': description,
        'postal_code': postalCode,
        'address': address,
      };
}
