import 'dart:ui';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/Model/OdersModel.dart';
import 'package:admin_panal/View/Order/orderInvoiceViewModel.dart';
import 'package:admin_panal/View/Widgets/DropDown/dropdownViewModel.dart';
import 'package:admin_panal/View/Widgets/Header/headerView.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sidenavbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final doc = pw.Document();

class OrderInvoice extends StatelessWidget {
  final OrderModel? m;
  OrderInvoice({this.m});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<InvoiceViewModel>.reactive(
        onModelReady: (model) => model.calculate(m!),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Color(0xf7f7f7f7),
              body: SingleChildScrollView(
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
                                    onDashboard: false,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 7,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Status :',
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),
                                            StatusDropdown(
                                              selectedState:
                                                  model.selectedState,
                                              items: model.items,
                                              onChange: (_) =>
                                                  model.onChange(m!.orderId, _),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0x70707070),
                                            ),
                                          ),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  75,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Image(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            12,
                                                        image: AssetImage(
                                                          'assets/images/logo.png',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          8,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Invoice #${m!.orderId}',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                0.5,
                                                          ),
                                                          Text(
                                                            'Date: ${m!.date}',
                                                            style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    0.75),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'From: ',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Super Store',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Store Address .................................................',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Phone: +445-442-9745',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'To: ',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            '${m!.username}',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            '${m!.address}',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Phone: +447-546-8817',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .blockSizeHorizontal *
                                                      7,
                                                ),
                                                child: Divider(),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    58,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            '#',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            'Item',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            'Store Name',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            'Unit Cost',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            'Vat',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          child: Text(
                                                            'Qty',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.5,
                                                          child: Text(
                                                            'Total',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              for (int i = 0;
                                                  i < m!.products!.length;
                                                  i++)
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      58,
                                                  color: i % 2 == 0
                                                      ? Color(0xF2F2F8F8)
                                                      : null,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '${i + 1}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '${m!.products![i].item}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '${m!.products![i].storeName}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '£ ${m!.products![i].unitPrice}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '${m!.products![i].vatt}%',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        child: Text(
                                                          '${m!.products![i].quantity}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            3.5,
                                                        child: Text(
                                                          '£${m!.products![i].total}',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              7),
                                                      // height: SizeConfig
                                                      //         .blockSizeVertical *
                                                      //     25,
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          25,
                                                      child: Column(
                                                        children: [
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Subtotal '),
                                                              Text(
                                                                  '£ ${model.subTotal.toStringAsFixed(2)}')
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Discount(${m!.discount}%) '),
                                                              Text(
                                                                  '£ ${model.minusAmount}')
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Total'),
                                                              Text(
                                                                  '£ ${model.grandTotal.toStringAsFixed(2)}')
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              5),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: accentColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                            'Print Invoice'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
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
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => InvoiceViewModel());
  }
}

Future invoice(OrderModel? m, var model) async {
  doc.addPage(
    pw.Page(
      build: (ctx) => pw.Container(
        width: SizeConfig.blockSizeHorizontal * 75,
        child: pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // pw.Container(
                //   child: pw.Image(
                //     pw.MemoryImage(
                //       'assets/images/logo.png',
                //     ),
                //     SizeConfig.blockSizeHorizontal * 8,
                //     SizeConfig.blockSizeVertical * 12,
                //     BoxFit.cover,
                //   ),
                // ),
                pw.Container(
                  width: SizeConfig.blockSizeHorizontal * 8,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Invoice #${m!.orderId}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      pw.Text(
                        'Date: ${m.date}',
                        style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 0.75),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'From: ',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        'Super Admin',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        'Admin Address .................................................',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        'Phone: +445-442-9745',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'To: ',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        '${m.username}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        '${m.address}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                      pw.SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      pw.Text(
                        'Phone: +447-546-8817',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            pw.Container(
              width: SizeConfig.blockSizeHorizontal * 58,
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 2,
                        child: pw.Text(
                          '#',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 4,
                        child: pw.Text(
                          'Item',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 5,
                        child: pw.Text(
                          'Store Name',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 4,
                        child: pw.Text(
                          'Unit Cost',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 4,
                        child: pw.Text(
                          'Vat',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 4,
                        child: pw.Text(
                          'Qty',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Spacer(),
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal * 3.5,
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            pw.SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            for (int i = 0; i < m.products!.length; i++)
              pw.Container(
                margin: pw.EdgeInsets.only(top: 10),
                width: SizeConfig.blockSizeHorizontal * 58,
                color: i % 2 == 0 ? PdfColors.lightBlue400 : null,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 2,
                      child: pw.Text(
                        '${i + 1}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 4,
                      child: pw.Text(
                        '${m.products![i].item}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 5,
                      child: pw.Text(
                        '${m.products![i].storeName}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 4,
                      child: pw.Text(
                        '£ ${m.products![i].unitPrice}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 4,
                      child: pw.Text(
                        '${m.products![i].vatt}%',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 4,
                      child: pw.Text(
                        '${m.products![i].quantity}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: SizeConfig.blockSizeHorizontal * 3.5,
                      child: pw.Text(
                        '£${m.products![i].total}',
                        style: pw.TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                children: [
                  pw.Container(
                    width: SizeConfig.blockSizeHorizontal * 25,
                    child: pw.Column(
                      children: [
                        pw.Divider(
                          color: PdfColors.black,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Subtotal '),
                            pw.Text('£ ${model.subTotal.toStringAsFixed(2)}')
                          ],
                        ),
                        pw.Divider(
                          color: PdfColors.black,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Discount(${m.discount}%) '),
                            pw.Text('£ ${model.minusAmount}')
                          ],
                        ),
                        pw.Divider(
                          color: PdfColors.black,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Total'),
                            pw.Text('£ ${model.grandTotal.toStringAsFixed(2)}')
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
    ),
  );
}

class PrintPageView extends StatefulWidget {
  final model;
  final OrderModel? m;
  PrintPageView({this.m, this.model});
  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPageView> {
  @override
  void initState() {
    super.initState();
    invoice(widget.m, widget.model);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: PdfPreview(build: (form) => doc.save()));
  }
}

class StatusDropdown extends StatefulWidget {
  final dynamic selectedState;
  final List<String>? items;
  final Function(String)? onChange;
  StatusDropdown({this.items, this.selectedState, this.onChange});
  @override
  _StatusDropdown createState() => _StatusDropdown();
}

class _StatusDropdown extends State<StatusDropdown> {
  dynamic _selectedState;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedState = widget.selectedState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        width: SizeConfig.blockSizeHorizontal * 14,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 1),
          child: Expanded(
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              onChanged: (val) {
                widget.onChange!(val!);
              },
              items: widget.items,
              hint: 'Status',
              selectedItem: widget.selectedState,
            ),
          ),
        ),
      ),
    );
  }
}
