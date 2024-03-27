import 'package:flutter/material.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import 'custom_image_view.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavhome,
      activeIcon: ImageConstant.imgNavhome,
      title: "Home",
      type: BottomBarEnum.Home,
      isPng: true,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavsearch,
      activeIcon: ImageConstant.imgNavsearch,
      title: "Search",
      type: BottomBarEnum.Search,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavscan,
      activeIcon: ImageConstant.imgNavscan,
      title: "Scan",
      type: BottomBarEnum.Scan,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavfollowed,
      activeIcon: ImageConstant.imgNavfollowed,
      title: "Followed",
      type: BottomBarEnum.Followed,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavmarket,
      activeIcon: ImageConstant.imgNavmarket,
      title: "Market",
      type: BottomBarEnum.Market,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(100),
      decoration: BoxDecoration(
        color: appTheme.teal300.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].isPng == true
                      ? null
                      : bottomMenuList[index].icon,
                  imagePath: bottomMenuList[index].isPng == true
                      ? bottomMenuList[index].icon
                      : null,
                  height: getSize(35),
                  width: getSize(35),
                  color: appTheme.blueGray900,
                ),
                Padding(
                  padding: getPadding(
                    top: 4,
                  ),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: appTheme.blueGray900,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].isPng == true
                      ? null
                      : bottomMenuList[index].activeIcon,
                  imagePath: bottomMenuList[index].isPng == true
                      ? bottomMenuList[index].activeIcon
                      : null,
                  height: getSize(35),
                  width: getSize(35),
                ),
                Padding(
                  padding: getPadding(
                    top: 4,
                  ),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.labelMediumRed300.copyWith(
                      color: appTheme.red300,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Search,
  Scan,
  Followed,
  Market,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
    this.isPng = false,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;

  bool isPng;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
