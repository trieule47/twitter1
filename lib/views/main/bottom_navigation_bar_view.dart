import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/fonts.dart';
import 'package:flutter_app/views/home/home_view.dart';
import 'package:get/get.dart';

class BottomNavigationBarView extends StatelessWidget {
  final selectedIndex = 0.obs;
  final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    HomeView()
  ]; // Init list widget options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: renderBody(), bottomNavigationBar: renderBottomNavigationBar());
  }

  /// Render body bottom bar
  Widget renderBody({BuildContext context}) {
    return Obx(
      () => Center(
        child: _widgetOptions.elementAt(selectedIndex.value),
      ),
    );
  }

  /// Render bottom navigation bar
  Widget renderBottomNavigationBar({BuildContext context}) {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex.value,
        selectedFontSize: Fonts.fontSizeSmall,
        unselectedFontSize: Fonts.fontSizeSmall,
        // This will be set when a new tab is tapped
        items: [
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     selectedIndex.value == 0
          //         ? Images.icHomeOrange
          //         : Images.icHomeGray,
          //   ),
          //   label: Localizes.home.tr,
          // ),
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     selectedIndex.value == 1
          //         ? Images.icAnnouncementOrange
          //         : Images.icAnnouncementGrey,
          //   ),
          //   label: Localizes.announcement.tr,
          // ),
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     selectedIndex.value == 2
          //         ? Images.icTimeTableOrange
          //         : Images.icTimeTableGray,
          //   ),
          //   label: Localizes.timeTable.tr,
          // ),
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     selectedIndex.value == 3
          //         ? Images.icAlbumOrange
          //         : Images.icAlbumGray,
          //   ),
          //   label: Localizes.album.tr,
          // ),
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     selectedIndex.value == 4
          //         ? Images.icProfileOrange
          //         : Images.icProfileGray,
          //   ),
          //   label: Localizes.account.tr,
          // )
        ],
        selectedItemColor: Colors.primary,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
      ),
    );
  }

  /// On tap item bottom bar
  void _onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
