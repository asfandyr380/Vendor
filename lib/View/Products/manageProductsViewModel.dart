import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Model/categoryModel.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/Model/storeModel.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class ManageProductsViewModel extends ChangeNotifier {
  ProductServices _productServices = locator<ProductServices>();
  Navigation _navigation = locator<Navigation>();
  List<ProductModel1> productlist = [];
  bool isLoading = false;
  StoreModel? storeModel;
  SuperCate? subCate;
  getProducts() async {
    isBusy(true);
    var result = await _productServices.getProducts(27);
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
    var result = await _productServices.filterByCate(key);
    if (result != 0) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  searchProducts(String key) async {
    isBusy(true);
    var result = await _productServices.filterProductsByName(key.toLowerCase());
    if (result != 0) {
      productlist = result;
      notifyListeners();
    }
    isBusy(false);
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
