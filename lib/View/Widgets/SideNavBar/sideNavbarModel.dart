import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class SideNavBarModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  navigateToSelectedPage(String page) async {
    print(page);
    switch (page) {
      case 'Dashboard':
        _navigation.navigateTo(Dashboard);
        break;
      case 'Add Products':
        _navigation.navigateTo(AddProducts);
        break;
      case 'Manage Products':
        _navigation.navigateTo(Manage, arguments: false);
        break;
      case 'All Products':
        _navigation.navigateTo(Manage, arguments: true);
        break;
      case 'Add Stores':
        _navigation.navigateTo(AddStores);
        break;
      case 'Manage Stores':
        _navigation.navigateTo(ManageStores);
        break;
      case 'Orders':
        _navigation.navigateTo(Orders);
        break;
      case 'Help':
        _navigation.navigateTo(Dashboard);
        break;
      case 'Categories':
        _navigation.navigateTo(Categories);
        break;
    }
  }
}
