import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/View/AdminConsole/adminConsoleView.dart';
import 'package:admin_panal/View/Order/OrderViewModel.dart';
import 'package:admin_panal/View/Products/addproductsView.dart';
import 'package:admin_panal/View/Widgets/Header/headerView.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sidenavbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<OrderViewModel>.reactive(
      viewModelBuilder: () => OrderViewModel(),
      onModelReady: (model) => model.orders(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xf7f7f7f7),
        body: Column(
          children: [
            Header(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 0.25,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 89.75,
                        width: SizeConfig.blockSizeHorizontal * 12.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Drawer(
                          child: leftSideNav(
                            onOrder: true,
                            onDashboard: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 3.5),
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.blockSizeVertical * 7),
                            ProductsContainer(
                              label: 'Orders',
                              content: Container(
                                width: SizeConfig.blockSizeHorizontal * 70,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical * 4),
                                    Container(
                                      child: TextFormField(
                                        onChanged: (e) => model.searchOrder(e),
                                        decoration: InputDecoration(
                                          labelText: "Filter Orders",
                                          labelStyle:
                                              TextStyle(color: accentColor),
                                          hintText:
                                              'Search By Username or PostalCode',
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide:
                                                BorderSide(color: accentColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    model.isLoading
                                        ? LinearProgressIndicator(
                                            color: accentColor,
                                            backgroundColor:
                                                accentColor.withOpacity(0.5),
                                          )
                                        : Container(),
                                    SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical * 3),
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(
                                            SizeConfig.blockSizeHorizontal *
                                                0.01),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                          ),
                                          children: [
                                            TableColumn(
                                              tableLabel: 'Sr. \nNo',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Username',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'SubTotal',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Coupon No',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Discount',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Postal Code',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Grand Total',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                            TableColumn(
                                              tableLabel: 'Action',
                                              tableStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                            ),
                                          ],
                                        ),
                                        for (int i = 0;
                                            i < model.orderlist.length;
                                            i++)
                                          TableRow(
                                            children: [
                                              TableColumn(
                                                tableLabel: '${i + 1}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '${model.orderlist[i].username}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '£${model.orderlist[i].subTotal}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '${model.orderlist[i].couponNo}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '${model.orderlist[i].discount}%',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '${model.orderlist[i].user_postalCode}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              TableColumn(
                                                tableLabel:
                                                    '£${model.orderlist[i].grandTotal}',
                                                tableStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockSizeVertical *
                                                        1),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: TextButton(
                                                            onPressed: () => model
                                                                .navigateToInvoice(
                                                              model
                                                                  .orderlist[i],
                                                            ),
                                                            child: Text(
                                                              'Cart Preview',
                                                              style: TextStyle(
                                                                color:
                                                                    accentColor,
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
