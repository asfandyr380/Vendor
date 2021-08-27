import 'dart:typed_data';
import 'dart:ui';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/View/Products/addproductsViewModel.dart';
import 'package:admin_panal/View/Widgets/DropDown/drop_Down.dart';
import 'package:admin_panal/View/Widgets/Header/headerView.dart';
import 'package:admin_panal/View/Widgets/SideNavBar/sidenavbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddProduct extends StatefulWidget {
  final ProductModel1? productModel;
  AddProduct({this.productModel});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ScrollController _controller = ScrollController();
  bool isVisiable = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          isVisiable = false;
        });
      } else {
        setState(() {
          isVisiable = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AddProductsViewModel>.reactive(
      onModelReady: (model) {
        model.checkModel(widget.productModel);
        if (widget.productModel != null) {
          model.getAttributes(widget.productModel!.id);
        }
      },
      builder: (context, model, child) => Scaffold(
        floatingActionButton: Visibility(
          visible: isVisiable,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () => widget.productModel == null
                    ? model.submitProduct().then((value) {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: 'Product Added Successfully',
                          ),
                          displayDuration: Duration(milliseconds: 150),
                        );
                      })
                    : model.updateProduct().then((value) {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: 'Product Successfully Updated',
                          ),
                          displayDuration: Duration(milliseconds: 150),
                        );
                        model.redirectBack();
                      }),
                label: model.isLoading
                    ? Container(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : Text(widget.productModel != null
                        ? 'UpdateProduct'
                        : 'Submit'),
                backgroundColor: accentColor,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                hoverElevation: 12,
                backgroundColor: Colors.white,
                label: Text(
                  'Save as Draft',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
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
                // Side NavBar
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
                            controller: _controller,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                ProductsContainer(
                                  label: 'Basic Information',
                                  content: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeConfig.blockSizeVertical * 4),
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Dropdown(
                                          clearSelection: () =>
                                              model.clearSelection(),
                                          generalSelectedState:
                                              model.selectedState,
                                          onSuperChange: (val) =>
                                              model.onSuperChange(val),
                                          onBrandChange: (val) =>
                                              model.onBrandChange(val),
                                          onGeneralChange: (val) =>
                                              model.onGeneralChange(val),
                                          onSubChange: (val) =>
                                              model.onSubChange(val),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        Container(
                                          child: CustomTextField(
                                            controller: model.nameController,
                                            onChange: (val) {
                                              model.name = val;
                                            },
                                            label: 'Product Name',
                                            hint: 'Enter Product Name',
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        Container(
                                          child: CustomTextField(
                                            controller:
                                                model.storePriceController,
                                            onChange: (val) {
                                              model.storeprice = val;
                                            },
                                            label: 'Store Price',
                                            hint: 'Enter Store Price',
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Vatt',
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1.25,
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                            ),
                                            RadioGroup.builder(
                                              groupValue: model.groupValue,
                                              activeColor: accentColor,
                                              onChanged: (_) =>
                                                  model.onRadioChange(_),
                                              items: ['Yes', 'No'],
                                              itemBuilder: (item) =>
                                                  RadioButtonBuilder(
                                                item as String,
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  16,
                                            ),
                                            model.groupValue == 'No'
                                                ? Container()
                                                : CustomTextField(
                                                    controller:
                                                        model.vattController,
                                                    hint: 'Enter Vatt',
                                                    onChange: (val) {
                                                      model.vatt = val;
                                                    },
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        DropArea(
                                          list: model.imagelist,
                                          isMultiSelect: true,
                                          onDrop: () => model.onDrop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                ProductsContainer(
                                  label: 'Attribute and Stock',
                                  content: Container(
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          controller: model.varientController,
                                          onChange: (val) {
                                            model.variant = val;
                                          },
                                          label: 'Variant',
                                          hint: 'Enter Variant',
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        CustomTextField(
                                          controller: model.stockController,
                                          onChange: (val) {
                                            model.stock = val;
                                          },
                                          label: 'Stock',
                                          hint: 'Enter Stock',
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        CustomTextField(
                                          controller: model.priceController,
                                          onChange: (val) {
                                            model.price = val;
                                          },
                                          label: 'Price',
                                          hint: 'Enter Price',
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 4,
                                        ),
                                        DropArea(
                                          list: model.attributeImglist,
                                          onDrop: () => model.onDropAttribute(),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                model.saveAttribute(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.upload,
                                                  size: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                                Text(
                                                  'Attributes',
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        0.75,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      6,
                                                  SizeConfig.blockSizeVertical *
                                                      2.5),
                                              primary: accentColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  60,
                                          child: Table(
                                            columnWidths: {
                                              0: FlexColumnWidth(SizeConfig
                                                      .blockSizeHorizontal *
                                                  0.01),
                                            },
                                            border: TableBorder.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 1),
                                            children: [
                                              TableRow(
                                                decoration: BoxDecoration(
                                                  color: Color(0xEEEEEEEE),
                                                ),
                                                children: [
                                                  TableColumn(
                                                      tableLabel: 'Sr. \nNo'),
                                                  TableColumn(
                                                      tableLabel: 'Image'),
                                                  TableColumn(
                                                      tableLabel: 'Variant'),
                                                  TableColumn(
                                                      tableLabel: 'Stock'),
                                                  TableColumn(
                                                      tableLabel: 'Price'),
                                                  TableColumn(
                                                      tableLabel: 'Action'),
                                                ],
                                              ),
                                              for (int i = 0;
                                                  i <
                                                      model.attributeModel
                                                          .length;
                                                  i++)
                                                TableRow(
                                                  children: [
                                                    TableColumn(
                                                      tableLabel: '${i + 1}',
                                                    ),
                                                    Column(
                                                      children: [
                                                        widget.productModel !=
                                                                null
                                                            ? Image.network(
                                                                model
                                                                    .attributeModel[
                                                                        i]
                                                                    .image!,
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    4,
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    4,
                                                              )
                                                            : Image.memory(
                                                                model
                                                                    .imageByte!,
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    4,
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    4,
                                                              ),
                                                      ],
                                                    ),
                                                    TableColumn(
                                                        tableLabel:
                                                            '${model.attributeModel[i].variant}'),
                                                    TableColumn(
                                                        tableLabel:
                                                            '${model.attributeModel[i].stock}'),
                                                    TableColumn(
                                                        tableLabel:
                                                            '£${model.attributeModel[i].price}'),
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () => model
                                                              .removeAttribute(
                                                                  i),
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                ProductsContainer(
                                  label: 'Detailed Description',
                                  content: Container(
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 5,
                                    ),
                                    child: Column(
                                      children: [
                                        TextEditor(
                                          controller: model.shortDescController,
                                          onChange: (val) {
                                            model.shortDesc = val;
                                          },
                                          maxLength: 50,
                                          label: "Short Description",
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 7,
                                        ),
                                        TextEditor(
                                          controller: model.longDescController,
                                          onChange: (val) {
                                            model.longDesc = val;
                                          },
                                          maxLength: 150,
                                          label: "Long Description",
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5,
                                ),
                                ProductsContainer(
                                  label: 'SEO (Optional)',
                                  content: Container(
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          controller: model.altDescController,
                                          onChange: (val) {
                                            model.altDesc = val;
                                          },
                                          label: 'Alt Description',
                                          hint: 'Enter Alt Description',
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        CustomTextField(
                                          controller:
                                              model.metaKeywordConrtoller,
                                          onChange: (val) {
                                            model.metakeyword = val;
                                          },
                                          label: 'Meta Keywords',
                                          hint:
                                              'Enter Meta Keywords (separate with commas)',
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Meta Description',
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1.25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  35,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      22,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Color(0x70707070),
                                                ),
                                              ),
                                              child: Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    18,
                                                child: TextFormField(
                                                  controller:
                                                      model.metaDescController,
                                                  onChanged: (val) {
                                                    model.metaDesc = val;
                                                  },
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  cursorColor: accentColor,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    contentPadding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .blockSizeVertical *
                                                            1,
                                                        left: SizeConfig
                                                                .blockSizeHorizontal *
                                                            1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 8,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Save As Draft',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              SizeConfig.blockSizeHorizontal *
                                                  9,
                                              SizeConfig.blockSizeVertical * 6),
                                          primary: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            model.submitProduct().then((_) {
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.success(
                                              message:
                                                  'Product Added Successfully',
                                            ),
                                            displayDuration:
                                                Duration(milliseconds: 150),
                                          );
                                        }),
                                        child: model.isLoading
                                            ? Container(
                                                height: 12,
                                                width: 12,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                widget.productModel != null
                                                    ? 'Update Product'
                                                    : 'Submit',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                              ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                            SizeConfig.blockSizeHorizontal * 9,
                                            SizeConfig.blockSizeVertical * 6,
                                          ),
                                          primary: accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 8,
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
      viewModelBuilder: () => AddProductsViewModel(),
    );
  }
}

class DropArea extends StatefulWidget {
  final Function()? onDrop;
  final List<Uint8List>? list;
  final bool? isMultiSelect;
  DropArea({this.onDrop, this.isMultiSelect, this.list});

  @override
  _DropAreaState createState() => _DropAreaState();
}

class _DropAreaState extends State<DropArea> {
  late DropzoneViewController _controller;
  bool hovering = false;
  onEnter(bool state) {
    setState(() {
      hovering = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool? _isMultiSelect = widget.isMultiSelect ?? false;

    return DottedBorder(
      strokeCap: StrokeCap.square,
      borderType: BorderType.Rect,
      dashPattern: [10, 10],
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.blockSizeVertical * 20,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            DropzoneView(
              onError: (err) => print(err),
              onCreated: (controller) => this._controller = controller,
              onDrop: (t) async {
                var img = await _controller.getFileData(t);
                widget.list!.add(img);
              },
            ),
            Center(
              child: widget.list!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload),
                        Text('Drag and Drop Logo Here'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final e = await _controller.pickFiles(
                                multiple: _isMultiSelect);
                            if (e.isEmpty)
                              return;
                            else {
                              for (var i in e) {
                                var img = await _controller.getFileData(i);
                                widget.list!.add(img);
                              }
                              widget.onDrop!();
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: accentColor),
                          icon: Icon(Icons.search),
                          label: Text('Choose Image'),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < widget.list!.length; i++)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (e) => onEnter(true),
                            onExit: (e) => onEnter(false),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.list!.remove(i);
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  height: SizeConfig.blockSizeVertical * 18,
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(widget.list![i]),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: hovering
                                          ? ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5)
                                          : ImageFilter.blur(
                                              sigmaX: 0.1, sigmaY: 0.1),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                          hovering
                                              ? Icon(Icons.close)
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  )),
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

class TextEditor extends StatefulWidget {
  final String? label;
  final int? maxLength;
  final Function(String)? onChange;
  final TextEditingController? controller;
  TextEditor({this.label, this.maxLength, this.onChange, this.controller});

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  bool isBold = false;
  bool isItalic = false;
  List toolbarIconData = [
    {'I': 1, 'State': false, 'Icon': Icons.format_align_left},
    {'I': 2, 'State': false, 'Icon': Icons.format_align_center},
    {'I': 3, 'State': false, 'Icon': Icons.format_align_right},
    {'I': 4, 'State': false, 'Icon': Icons.format_list_numbered},
    {'I': 5, 'State': false, 'Icon': Icons.format_list_bulleted},
    {'I': 6, 'State': false, 'Icon': Icons.format_bold},
    {'I': 7, 'State': false, 'Icon': Icons.format_italic},
    {'I': 8, 'State': false, 'Icon': Icons.format_underline},
  ];
  TextAlign align = TextAlign.left;

  alignText(int i) {
    switch (i) {
      case 1:
        setState(() {
          align = TextAlign.left;
        });
        break;
      case 2:
        setState(() {
          align = TextAlign.center;
        });
        break;
      case 3:
        setState(() {
          align = TextAlign.right;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.blockSizeHorizontal * 15,
          child: Column(
            children: [
              Text(
                '${widget.label}',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 55,
              height: SizeConfig.blockSizeVertical * 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: Color(0x70707070),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 5,
                        width: SizeConfig.blockSizeHorizontal * 54.90,
                        decoration: BoxDecoration(
                          color: Color(0xF8F8F8F8),
                          border: Border.all(
                            width: 0.5,
                            color: Color(0x70707070),
                          ),
                        ),
                        child: Row(
                          children: [
                            for (var tool in toolbarIconData)
                              ToolbarIcon(
                                  isSelected: tool['State'],
                                  onTap: () {
                                    if (tool['I'] == 6) {
                                      setState(() {
                                        if (isBold)
                                          isBold = false;
                                        else
                                          isBold = true;
                                      });
                                    }
                                    if (tool['I'] == 7) {
                                      setState(() {
                                        if (isItalic)
                                          isItalic = false;
                                        else
                                          isItalic = true;
                                      });
                                    }
                                    alignText(tool["I"]);
                                    setState(() {
                                      if (tool['State'])
                                        tool['State'] = false;
                                      else
                                        tool['State'] = true;
                                    });
                                  },
                                  icon: tool['Icon']),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 22,
                    child: TextFormField(
                      controller: widget.controller,
                      onChanged: (val) => widget.onChange!(val),
                      textAlign: align,
                      maxLength: widget.maxLength,
                      style: TextStyle(
                        fontWeight: isBold ? FontWeight.bold : null,
                        fontStyle: isItalic ? FontStyle.italic : null,
                      ),
                      keyboardType: TextInputType.multiline,
                      cursorColor: accentColor,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1,
                            left: SizeConfig.blockSizeHorizontal * 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ToolbarIcon extends StatelessWidget {
  final Function? onTap;
  final IconData? icon;
  final bool? isSelected;
  ToolbarIcon({this.icon, this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    bool _isSeleted = isSelected ?? false;
    return IconButton(
      onPressed: () => onTap!(),
      icon: Icon(
        icon,
        color: _isSeleted ? accentColor : null,
        size: SizeConfig.blockSizeHorizontal * 1.25,
      ),
    );
  }
}

class ProductsContainer extends StatelessWidget {
  final Widget? content;
  final String? label;
  ProductsContainer({this.content, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 75,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
            height: SizeConfig.blockSizeVertical * 5,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              '$label',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 1.75,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content!,
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Function(String)? onChange;
  final Function(String)? validate;
  final TextEditingController? controller;
  final bool? onCate;
  CustomTextField(
      {this.label,
      this.hint,
      this.onChange,
      this.validate,
      this.controller,
      this.onCate});
  @override
  Widget build(BuildContext context) {
    bool _onCate = onCate ?? false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label == null
            ? Container()
            : Text(
                '$label',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1.25,
                ),
              ),
        Container(
          height: SizeConfig.blockSizeVertical * 4,
          width: SizeConfig.blockSizeHorizontal * 35,
          child: TextFormField(
            controller: controller,
            onChanged: (val) => onChange!(val),
            cursorColor: accentColor,
            validator: (val) => validate!(val!),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 1,
                  left: SizeConfig.blockSizeHorizontal * 1),
              hintText: '$hint',
              hintStyle: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UploadButton extends StatelessWidget {
  late final String? label;
  late final String? logohint;
  UploadButton({this.label, this.logohint});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label',
          style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 1.25,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.upload,
                  size: SizeConfig.blockSizeHorizontal * 1,
                ),
                Text(
                  '$logohint',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 0.75,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(SizeConfig.blockSizeHorizontal * 6,
                  SizeConfig.blockSizeVertical * 2.5),
              primary: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}

class TableColumn extends StatelessWidget {
  final String? tableLabel;
  final TextStyle? tableStyle;

  TableColumn({required this.tableLabel, this.tableStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1,
      ),
      child: Center(
        child: Text(
          '$tableLabel',
          overflow: TextOverflow.ellipsis,
          style: tableStyle,
        ),
      ),
    );
  }
}
