import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/View/Products/addproductsView.dart';
import 'package:admin_panal/View/Widgets/DropDown/drop_Down.dart';
import 'package:admin_panal/View/Widgets/Header/headerView.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sidenavbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'manageProductsViewModel.dart';

class ManageProducts extends StatelessWidget {
  final bool? isAll;
  ManageProducts({this.isAll});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isAll = isAll ?? false;
    return ViewModelBuilder<ManageProductsViewModel>.reactive(
      viewModelBuilder: () => ManageProductsViewModel(),
      onModelReady: (model) {
        if (_isAll) {
          model.getAllProducts();
        } else {
          model.getProducts();
        }
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xf7f7f7f7),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
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
                          height: SizeConfig.blockSizeVertical * 100,
                          width: SizeConfig.blockSizeHorizontal * 12.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Drawer(
                            child: leftSideNav(
                              onProduct: true,
                              onDashboard: false,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          height: SizeConfig.blockSizeVertical * 100,
                          padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 5,
                            bottom: SizeConfig.blockSizeVertical * 5,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 7),
                                ProductsContainer(
                                  label: 'Manage Products',
                                  content: Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    4),
                                        Container(
                                          child: TextFormField(
                                            onChanged: (e) =>
                                                model.searchProducts(e),
                                            decoration: InputDecoration(
                                              labelText: "Filter Products",
                                              labelStyle:
                                                  TextStyle(color: accentColor),
                                              hintText: 'Search By Name',
                                              border: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: accentColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        model.isLoading
                                            ? LinearProgressIndicator(
                                                color: accentColor,
                                                backgroundColor: accentColor
                                                    .withOpacity(0.5),
                                              )
                                            : Container(),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    3),
                                        FilterDropDown(
                                          onSuperChange: (val) =>
                                              model.onSuperChange(val),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    3),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Image',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Products Title',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Super Category',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Store',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Decription',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TableColumn(
                                                  tableLabel: 'Action',
                                                  tableStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            for (int i = 0;
                                                i < model.productlist.length;
                                                i++)
                                              TableRow(
                                                children: [
                                                  TableColumn(
                                                    tableLabel: '${i + 1}',
                                                  ),
                                                  Column(
                                                    children: [
                                                      Image(
                                                        image: NetworkImage(
                                                          '${model.productlist[i].images[0]}',
                                                        ),
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            5,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            5,
                                                      ),
                                                    ],
                                                  ),
                                                  TableColumn(
                                                      tableLabel:
                                                          '${model.productlist[i].name}'),
                                                  TableColumn(
                                                      tableLabel:
                                                          '${model.productlist[i].subCate}'),
                                                  TableColumn(
                                                      tableLabel:
                                                          '${model.productlist[i].storename}'),
                                                  TableColumn(
                                                    tableLabel:
                                                        '${model.productlist[i].description}',
                                                  ),
                                                  _isAll
                                                      ? Center(
                                                          child: TextButton(
                                                          onPressed: () => model
                                                              .navigateToAllProduct(
                                                            model
                                                                .productlist[i],
                                                          ),
                                                          child: Text(
                                                            'Me Too',
                                                            style: TextStyle(
                                                                color:
                                                                    accentColor),
                                                          ),
                                                        ))
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                IconButton(
                                                                  onPressed:
                                                                      () => model
                                                                          .navigateToAddProduct(
                                                                    model.productlist[
                                                                        i],
                                                                  ),
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (BuildContext ctx) => alert(
                                                                            ctx,
                                                                            model.productlist[i]));
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove_red_eye,
                                                                    color:
                                                                        accentColor,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (ctx) =>
                                                                            DeleteAlert(
                                                                              onConfirm: (val) => model.deleteProduct(model.productlist[i].id, i, val).then((value) {
                                                                                if (value) {
                                                                                  if (value) {
                                                                                    showTopSnackBar(
                                                                                      context,
                                                                                      CustomSnackBar.success(
                                                                                        message: 'Product Removed Successfully',
                                                                                      ),
                                                                                      displayDuration: Duration(milliseconds: 150),
                                                                                    );
                                                                                  } else {
                                                                                    showTopSnackBar(
                                                                                      context,
                                                                                      CustomSnackBar.error(
                                                                                        message: 'Something Went Wrong try again',
                                                                                      ),
                                                                                      displayDuration: Duration(milliseconds: 150),
                                                                                    );
                                                                                  }
                                                                                }
                                                                              }),
                                                                            ));
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    4),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
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
      ),
    );
  }
}

class DeleteAlert extends StatelessWidget {
  final Function(String)? onConfirm;
  // final Function(String)? validate;
  DeleteAlert({this.onConfirm});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            // validator: (val) => validate!(val!),
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            "Confirm",
            style: TextStyle(color: accentColor),
          ),
          onPressed: () {
            onConfirm!(_controller.text);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: accentColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

Widget alert(BuildContext ctx, ProductModel1 model) {
  return AlertDialog(
    title: Text("${model.name}"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          '${model.images[0]}',
          fit: BoxFit.contain,
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 20,
        ),
        InfoFields(
          label: 'Store Name',
          name: model.storename,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        InfoFields(
          label: 'Price',
          name: model.price.toString(),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        InfoFields(
          label: 'Sale Price',
          name: model.salePrice.toString(),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        InfoFields(
          label: 'Sold',
          name: model.sold.toString(),
        ),
        // SizedBox(height: SizeConfig.blockSizeVertical * 1),
        // InfoFields(
        //   label: 'Sold',
        //   name: model.,
        // ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Text('Description'),
        Text(
          model.description!,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.9),
        ),
      ],
    ),
    actions: [
      TextButton(
        child: Text(
          "OK",
          style: TextStyle(color: accentColor),
        ),
        onPressed: () => Navigator.pop(ctx),
      ),
    ],
  );
}

class InfoFields extends StatelessWidget {
  final String label;
  final String? name;
  const InfoFields({required this.label, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: accentColor),
        ),
        Container(
            width: SizeConfig.blockSizeHorizontal * 8,
            alignment: Alignment.centerRight,
            child: Text('$name')),
      ],
    );
  }
}
