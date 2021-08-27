import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/Model/brandsModel.dart';
import 'package:admin_panal/Model/categoryModel.dart';
import 'package:admin_panal/Model/storeModel.dart';
import 'package:admin_panal/Services/Api/Brands/BrandsServices.dart';
import 'package:admin_panal/Services/Api/Category/category_services.dart';
import 'package:admin_panal/Services/Api/Store/storeServices.dart';
import 'package:admin_panal/View/Widgets/DropDown/dropdownViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../CategoryLabel.dart';

class Dropdown extends StatefulWidget {
  final ValueChanged<StoreModel>? onStoreChange;
  final ValueChanged<GeneralCate>? onGeneralChange;
  final ValueChanged<SuperCate>? onSuperChange;
  final ValueChanged<SubCate>? onSubChange;
  final ValueChanged<Brand>? onBrandChange;
  final Function? clearSelection;
  final bool? onCate;
  GeneralCate? generalSelectedState;
  Dropdown(
      {this.onBrandChange,
      this.clearSelection,
      this.generalSelectedState,
      this.onGeneralChange,
      this.onStoreChange,
      this.onSubChange,
      this.onSuperChange,
      this.onCate});
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  CategoryServices _categoryServices = locator<CategoryServices>();
  BrandServices _brandServices = locator<BrandServices>();
  StoreServices _storeServices = locator<StoreServices>();
  List<GeneralCate> generallist = [];
  List<SuperCate> superCate = [];
  List<SubCate> subCate = [];
  List<Brand> brandlist = [];
  List<StoreModel> storelist = [];
  Brand? brandState;
  SuperCate? superSelectedState;
  // GeneralCate? selectedState;
  SubCate? subState;
  StoreModel? store;

  onClear() {
    widget.clearSelection!();
    widget.generalSelectedState = null;
  }

  onChange(GeneralCate state) {
    superSelectedState = null;
    setState(() {
      widget.generalSelectedState = state;
    });
    _categoryServices
        .getSuperCate(widget.generalSelectedState!.cateId!)
        .then((value) {
      setState(() {
        superCate = value;
      });
    });
    widget.onGeneralChange!(state);
  }

  onChangeSuper(SuperCate state) {
    subState = null;
    setState(() {
      superSelectedState = state;
    });
    _categoryServices.getSubCate(superSelectedState!.superId!).then((value) {
      setState(() {
        subCate = value;
        print(subCate);
      });
    });
    widget.onSuperChange!(state);
  }

  onChangeSub(SubCate state) {
    setState(() {
      subState = state;
    });
    widget.onSubChange!(state);
  }

  onChangeBrand(Brand state) {
    setState(() {
      brandState = state;
    });
    widget.onBrandChange!(state);
  }

  @override
  void initState() {
    super.initState();
    _categoryServices.getGeneralCate().then((value) {
      setState(() {
        generallist = value;
      });
      _brandServices.getBrands().then((value) {
        setState(() {
          brandlist = value;
        });
      });
    });
    _storeServices.getStores().then((stores) {
      setState(() {
        storelist = stores;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _onCate = widget.onCate ?? false;
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label(
                label: 'General Category',
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                child: DropdownSuper(
                  hintText: 'Select General Category',
                  items: generallist,
                  selectedState: widget.generalSelectedState,
                  onChange: (state) => onChange(state),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label(
                label: 'Super Category',
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                child: DropdownSuper(
                  hintText: 'Select Super Category',
                  items: superCate,
                  selectedState: superSelectedState,
                  onChange: (state) => onChangeSuper(state),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label(
                label: 'Sub Category',
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                child: DropdownSuper(
                  hintText: 'Select Sub Category',
                  items: subCate,
                  selectedState: subState,
                  onChange: (state) => onChangeSub(state),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Visibility(
            visible: !_onCate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  label: 'Brands',
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  child: DropdownSuper(
                    hintText: 'Select Brand',
                    items: brandlist,
                    selectedState: brandState,
                    onChange: (state) => onChangeBrand(state),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDropDown extends StatefulWidget {
  final ValueChanged<StoreModel>? onStoreChange;
  final ValueChanged<SuperCate>? onSuperChange;
  FilterDropDown({
    this.onStoreChange,
    this.onSuperChange,
  });

  @override
  _FilterDropDownState createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  CategoryServices _categoryServices = locator<CategoryServices>();
  List<SuperCate> superCate = [];
  SuperCate? superSelectedState;

  onChangeSuper(SuperCate state) {
    setState(() {
      superSelectedState = state;
    });
    widget.onSuperChange!(state);
  }

  @override
  void initState() {
    super.initState();
    _categoryServices.getAllSuperCate().then((value) {
      setState(() {
        superCate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        width: SizeConfig.blockSizeHorizontal * 20,
        child: DropdownSuper(
          hintText: 'Select Super Category',
          items: superCate,
          selectedState: superSelectedState,
          onChange: (state) => onChangeSuper(state),
        ),
      ),
    );
  }
}

class DropdownSuper extends StatefulWidget {
  final dynamic selectedState;
  final List? items;
  final String? hintText;
  final Function? valAsString;
  final Function(dynamic)? onChange;
  DropdownSuper(
      {this.items,
      this.selectedState,
      this.onChange,
      this.hintText,
      this.valAsString});
  @override
  _DropdownSuperState createState() => _DropdownSuperState();
}

class _DropdownSuperState extends State<DropdownSuper> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        width: SizeConfig.blockSizeHorizontal * 35,
        height: SizeConfig.blockSizeVertical * 5,
        child: DropdownSearch<dynamic>(
          mode: Mode.MENU,
          showSearchBox: true,
          onChanged: (val) => widget.onChange!(val!),
          items: widget.items,
          itemAsString: (val) => '${val.name}',
          hint: widget.hintText,
          selectedItem: widget.selectedState,
        ),
      ),
    );
  }
}
