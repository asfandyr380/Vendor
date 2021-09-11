import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Model/categoryModel.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/Model/storeModel.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class ManageProductsViewModel extends ChangeNotifier {
  ProductServices _productServices = locator<ProductServices>();
  Navigation _navigation = locator<Navigation>();
  StorageServices _storageServices = locator<StorageServices>();
  List<ProductModel1> productlist = [];
  bool isLoading = false;
  StoreModel? storeModel;
  SuperCate? subCate;
  getProducts() async {
    isBusy(true);
    int userId = await _storageServices.getUserId();
    var result = await _productServices.getProducts(userId);
    if (result is List<ProductModel1>) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  onSuperChange(val) {
    subCate = val;
    notifyListeners();
    filterByCate(subCate!.name);
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  filterBySuperCate(String key) async {
    isBusy(true);
    var result = await _productServices.filterProductByStore(key);
    if (result != 0) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  filterProductByStore(String key) async {
    isBusy(true);
    var result = await _productServices.filterProductByStore(key);
    if (result != 0) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  filterByCate(String key) async {
    isBusy(true);
    int userId = await _storageServices.getUserId();
    var result = await _productServices.filterByCate(key, userId);
    if (result != 0) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  searchProducts(String key) async {
    if (key.isNotEmpty) {
      isBusy(true);
      int userId = await _storageServices.getUserId();
      var result = await _productServices.filterProductsByName(
          key.toLowerCase(), userId);
      if (result != 0) {
        productlist = result;
        notifyListeners();
      }
      isBusy(false);
    } else {
      getProducts();
    }
  }

  navigateToAddProduct(ProductModel1 m) async {
    _navigation.navigateTo(AddProducts, arguments: m);
  }

  Future deleteProduct(int id, int currentIdx, String pass) async {
    var result = await _productServices.removeProduct(id, pass);
    if (result == 1) {
      productlist.removeAt(currentIdx);
      notifyListeners();
      return true;
    } else
      return false;
  }
}
