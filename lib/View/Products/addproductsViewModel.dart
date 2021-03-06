import 'dart:typed_data';
import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Model/attributeModel.dart';
import 'package:admin_panal/Model/categoryModel.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/Services/Api/Attribute/AttributeServices.dart';
import 'package:admin_panal/Services/Api/Category/category_services.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:admin_panal/View/Products/manageProducts.dart';
import 'package:flutter/material.dart';

class AddProductsViewModel extends ChangeNotifier {
  ProductServices _productServices = locator<ProductServices>();
  CategoryServices _categoryService = locator<CategoryServices>();
  AttributeService _attributeService = locator<AttributeService>();
  StorageServices _storageServices = locator<StorageServices>();
  Navigation _navigation = locator<Navigation>();
  Uint8List? imageByte;
  List<Uint8List> imagelist = [];
  List<Uint8List> attributeImglist = [];
  bool isLoading = false;
  String name = '';
  String storeprice = '0';
  String salePrice = '';
  String shortDesc = '';
  String longDesc = '';
  String altDesc = '';
  String metakeyword = '';
  String metaDesc = '';
  String generalcate = '';
  String? supercate;
  String? subcate;
  String? brand;
  String stock = '0';
  String variant = '';
  String price = '0';
  String vatt = '';
  String attrubuteSalePrice = '';
  List<AttributeModel> attributeModel = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController storePriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController longDescController = TextEditingController();
  TextEditingController altDescController = TextEditingController();
  TextEditingController metaKeywordConrtoller = TextEditingController();
  TextEditingController metaDescController = TextEditingController();
  TextEditingController varientController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController attributeSalePriceController = TextEditingController();
  TextEditingController vattController = TextEditingController();
  // Product Id
  int id = 0;
  int cateId = 0;
  int attributeStatus = 0;
  List<String> editImageList = [];
  int onSaleStatus = 0;
  checkModel(ProductModel1? model) {
    if (model != null) {
      nameController.text = model.name!;
      storePriceController.text = model.price.toString();
      salePriceController.text = model.salePrice.toString();
      shortDescController.text = model.description ?? '';
      longDescController.text = model.description ?? '';
      altDescController.text = model.altTag ?? '';
      metaDescController.text = model.metaDesc ?? '';
      metaKeywordConrtoller.text = model.metakeywords ?? '';
      id = model.id;
      cateId = model.cateId!;
      attributeStatus = model.attributeStatus!;
      editImageList = model.rawImgs;
      onSaleStatus = model.onSale!;
      notifyListeners();
      getProductCate();
    }
  }

  getProductCate() async {
    var result = await _categoryService.getProductCate(cateId);
    generalcate = result['main'];
    supercate = result['super'];
    subcate = result['sub'];
  }

  String groupValue = 'No';
  onRadioChange(val) {
    groupValue = val;
    notifyListeners();
  }

  GeneralCate? selectedState;
  int attributeLength = 0;
  String attributeimg = '';
  getAttributes(int id) async {
    var result = await _attributeService.getAttribute(id);
    if (result != 0) {
      if (result != []) {
        attributeModel = result;
        notifyListeners();
      }
      attributeLength = attributeModel.length;
      attributeimg = attributeModel[0].image ?? '';
    }
  }

  onDrop() async {
    if (imagelist.isNotEmpty) {
      imagelist = imagelist;
      notifyListeners();
    }
  }

  onDropAttribute() async {
    if (attributeImglist.isNotEmpty) {
      imageByte = attributeImglist[0];
      notifyListeners();
    }
  }

  onSuperChange(val) {
    supercate = val.name;
    notifyListeners();
  }

  onBrandChange(val) {
    brand = val.name;
    notifyListeners();
  }

  onGeneralChange(val) {
    generalcate = val.name!;
    notifyListeners();
  }

  onSubChange(val) {
    subcate = val.name;
    notifyListeners();
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future addCatefirst() async {
    CategoryModel _model = CategoryModel(
        generalCate: generalcate, superCate: supercate, subCate: subcate);
    Map data = _model.toJson();
    var result = await _categoryService.addCategory(data);
    if (result != 0) {
      return result;
    } else {
      print(result);
    }
  }

  Future updateProduct() async {
    isBusy(true);
    int userId = await _storageServices.getUserId();
    ProductModel _model;
    await updateCate(cateId);
    if (imagelist.isNotEmpty) {
      List imageresult = await _productServices.uploadImages(imagelist);
      _model = ProductModel(
        name: nameController.text,
        price: storePriceController.text,
        salePrice: salePriceController.text,
        description: longDescController.text,
        cateId: cateId.toString(),
        altTag: altDescController.text,
        metaDesc: metaDescController.text,
        metakeywords: metaKeywordConrtoller.text,
        storeId: userId.toString(),
        searchKey: nameController.text.toLowerCase(),
        attributeStatus: attributeStatus.toString(),
        status: '0',
        image2: imageresult.asMap().containsKey(1)
            ? imageresult[1]['filename']
            : '',
        image3: imageresult.asMap().containsKey(2)
            ? imageresult[2]['filename']
            : '',
        image4: imageresult.asMap().containsKey(3)
            ? imageresult[3]['filename']
            : '',
        image: imageresult[0]['filename'],
        shortDesc: shortDescController.text,
        onSale: onSaleStatus.toString(),
        vatt: vattController.text,
      );
    } else {
      _model = ProductModel(
        name: nameController.text,
        price: storePriceController.text,
        salePrice: salePriceController.text,
        description: longDescController.text,
        cateId: cateId.toString(),
        altTag: altDescController.text,
        metaDesc: metaDescController.text,
        metakeywords: metaKeywordConrtoller.text,
        storeId: userId.toString(),
        searchKey: nameController.text.toLowerCase(),
        attributeStatus: attributeStatus.toString(),
        status: '0',
        image2: editImageList.asMap().containsKey(1) ? editImageList[1] : '',
        image3: editImageList.asMap().containsKey(2) ? editImageList[2] : '',
        image4: editImageList.asMap().containsKey(3) ? editImageList[3] : '',
        image: editImageList[0],
        shortDesc: shortDescController.text,
        onSale: onSaleStatus.toString(),
        vatt: vattController.text,
      );
    }
    Map data = _model.toJson();
    var result = await _productServices.updateProduct(id, data);
    isBusy(false);

    if (result != 0) {
      if (attributeModel.isEmpty) {
        updateStatus(0);
      } else {
        updateStatus(1);
      }
      if (attributeModel.isNotEmpty) {
        if (attributeModel.length > attributeLength) {
          attributeModel.removeRange(0, attributeLength);
          if (attributeStatus == 1) {
            await addMorettribute(id);
          } else {
            await addAttribute(id);
          }
        }
      }
      return true;
    } else {
      print(result);
    }
  }

  updateStatus(int state) async {
    await _attributeService.updateStatus(id.toString(), state);
  }

  redirectBack() async {
    _navigation.pushReplaceRoute(ManageProducts());
  }

  Future updateCate(int id) async {
    Map map = {
      "mainCate": generalcate,
      "superCate": supercate,
      "subCateName": subcate,
    };
    var result = await _categoryService.updateProductCate(id, map);
    if (result != 0) return result;
  }

  Future submitProduct() async {
    if (imagelist.isNotEmpty) {
      isBusy(true);
      int cateId = await addCatefirst();
      var storeId = await _storageServices.getUserId();

      List imageresult = await _productServices.uploadImages(imagelist);
      ProductModel _model = ProductModel(
        name: name,
        price: storeprice,
        salePrice: '0',
        description: longDesc,
        cateId: cateId.toString(),
        altTag: altDesc,
        metaDesc: metaDesc,
        metakeywords: metakeyword,
        storeId: storeId.toString(),
        searchKey: name.toLowerCase(),
        attributeStatus: '0',
        status: '0',
        image2: imageresult.asMap().containsKey(1)
            ? imageresult[1]['filename']
            : '',
        image3: imageresult.asMap().containsKey(2)
            ? imageresult[2]['filename']
            : '',
        image4: imageresult.asMap().containsKey(3)
            ? imageresult[3]['filename']
            : '',
        image: imageresult[0]['filename'],
        onSale: salePrice.isNotEmpty ? '1' : '0',
        shortDesc: shortDesc,
        vatt: vatt,
      );
      Map data = _model.toJson();
      var result = await _productServices.addProduct(data);
      if (result != 0) {
        print('Product Added Successfuly');
        if (attributeModel.isNotEmpty) {
          await addAttribute(result);
        }
        isBusy(false);
        nameController.clear();
        storePriceController.clear();
        salePriceController.clear();
        shortDescController.clear();
        longDescController.clear();
        altDescController.clear();
        metaDescController.clear();
        metaKeywordConrtoller.clear();
        varientController.clear();
        stockController.clear();
        priceController.clear();
        attributeSalePriceController.clear();
        vattController.clear();
        attributeModel = [];
        imagelist = [];
        imageByte = null;
        imagelist = [];
        attributeImglist = [];
        selectedState = null;
        clearSelection();
        return true;
      } else {
        print(result);
        return false;
      }
    } else {
      print("No Image Selected");
      return false;
    }
  }

  clearSelection() {
    selectedState = null;
  }

  saveAttribute() {
    var data =
        AttributeModel.fromJson(int.parse(stock), variant, double.parse(price));
    attributeModel.add(data);
    notifyListeners();
  }

  removeAttribute(int currentIdx) {
    attributeModel.removeAt(currentIdx);
    notifyListeners();
  }

  Future addMorettribute(int id) async {
    for (var model in attributeModel) {
      Map data = model.toJson();
      var result = await _attributeService.addAttribute(data, id, attributeimg);
      if (result != 0) {
        print(result);
      }
    }
  }

  Future addAttribute(int id) async {
    var image = await _attributeService.uploadImage(imageByte!);
    for (var model in attributeModel) {
      Map data = model.toJson();
      var result = await _attributeService.addAttribute(data, id, image);
      if (result != 0) {
        print(result);
      }
    }
  }
}
