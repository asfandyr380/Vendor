import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/View/AdminConsole/adminConsoleViewModel.dart';
import 'package:admin_panal/View/Widgets/Header/headerView.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sidenavbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class AdminConsoleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AdminConsoleViewModel>.reactive(
      viewModelBuilder: () => AdminConsoleViewModel(),
      onModelReady: (model) {
        model.countOrder();
        model.countProducts();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xf7f7f7f7),
        body: Column(
          children: [
            Header(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 0.25,
            ),
            Container(
              // Side NavBar
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 89,
                          width: SizeConfig.blockSizeHorizontal * 12.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Drawer(
                            child: leftSideNav(
                              onDashboard: true,
                            ),
                          ),
                        ),
                        Column(
                          //Dashboard Layout
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 89,
                              width: SizeConfig.blockSizeHorizontal * 87.5,
                              decoration: BoxDecoration(
                                color: Color(0xf7f7f7f7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.blockSizeVertical * 3),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        dashItems(
                                          onTap: () => model.navigateToOrders(),
                                          label: 'Order',
                                          itemCount: model.orderCount,
                                        ),
                                        dashItems(
                                          onTap: () {},
                                          label: 'Total Products',
                                          itemCount: model.productCount,
                                        ),
                                        dashItems(label: 'Returns'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class dashItems extends StatelessWidget {
  final String? itemCount;
  final String label;
  final Function? onTap;
  dashItems({this.itemCount, required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    String _itemCount = itemCount ?? '0';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap!(),
        child: Container(
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              begin: Alignment(0.9, -0.59),
              end: Alignment(-1.0, 1.18),
              colors: [const Color(0x944d9650), const Color(0xff40a944)],
              stops: [0.0, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(3, 3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_itemCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 3,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Text(
                '$label',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
