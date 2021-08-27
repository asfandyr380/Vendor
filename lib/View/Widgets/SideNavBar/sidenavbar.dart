import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sideNavbarModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class leftSideNav extends StatelessWidget {
  final bool? onDashboard;
  final bool? onProduct;
  final bool? onStore;
  final bool? onOrder;
  final bool? onCate;
  leftSideNav({
    this.onCate,
    this.onOrder,
    this.onProduct,
    this.onStore,
    this.onDashboard,
  });

  List<Map<String, dynamic>> _navBarItem = [
    {
      'Name': 'Products',
      'Items': ['Add Products', 'Manage Products'],
      'isSelected': false,
    },
    {
      'Name': 'Stores',
      'Items': ['Add Stores', 'Manage Stores'],
      'isSelected': false,
    },
    {
      'Name': 'Orders',
      'Items': null,
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool _onDashboard = onDashboard ?? false;
    bool _onCate = onCate ?? false;
    bool _onOrder = onOrder ?? false;
    bool _onStore = onStore ?? false;
    bool _onProduct = onProduct ?? false;
    return ViewModelBuilder<SideNavBarModel>.reactive(
        builder: (context, model, child) => Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
              child: ListView(
                children: [
                  ListTile(
                    onTap: () => model.navigateToSelectedPage('Dashboard'),
                    mouseCursor: SystemMouseCursors.click,
                    tileColor: _onDashboard ? primaryColor : null,
                    title: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        fontWeight: FontWeight.w500,
                        color: _onDashboard ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    iconColor: accentColor,
                    textColor: accentColor,
                    collapsedBackgroundColor: _onProduct ? primaryColor : null,
                    collapsedTextColor:
                        _onProduct ? Colors.white : Colors.black,
                    children: [
                      ListTile(
                        onTap: () =>
                            model.navigateToSelectedPage('Add Products'),
                        mouseCursor: SystemMouseCursors.click,
                        title: Text('Add Product',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 1)),
                      ),
                      ListTile(
                        onTap: () =>
                            model.navigateToSelectedPage('Manage Products'),
                        mouseCursor: SystemMouseCursors.click,
                        title: Text('Manage Product',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 1)),
                      ),
                    ],
                    title: Text(
                      'Product',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () => model.navigateToSelectedPage('Orders'),
                    tileColor: _onOrder ? primaryColor : null,
                    title: Text(
                      'Orders',
                      style: TextStyle(
                        color: _onOrder ? Colors.white : Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () => model.navigateToSelectedPage('Report'),
                    title: Text(
                      'Report',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () => model.navigateToSelectedPage('Help'),
                    title: Text(
                      'Help',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SideNavBarModel());
  }
}
