import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/View/Widgets/Header/headerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HeaderViewModel>.reactive(
      viewModelBuilder: () => HeaderViewModel(),
      onModelReady: (model) => model.getStoreLogo(),
      builder: (ctx, model, child) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.3)),
          ],
        ),
        // Header
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: SizeConfig.blockSizeVertical * 10,
                width: SizeConfig.blockSizeHorizontal * 100,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2.5),
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: SizeConfig.blockSizeHorizontal * 100,
                        width: SizeConfig.blockSizeHorizontal * 10,
                        child: Image(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          height: SizeConfig.blockSizeVertical * 120,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.signout(),
                        child: Container(
                          child: model.img.isEmpty
                              ? FaIcon(
                                  FontAwesomeIcons.userAlt,
                                  size: SizeConfig.blockSizeHorizontal * 2.5,
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(model.img)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
