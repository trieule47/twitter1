import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/fonts.dart';
import 'package:flutter_app/values/images.dart';
import 'package:get/get.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});

  final TabItem currentTab; // Current tab
  final ValueChanged<TabItem> onSelectTab; // On selected tab
  final _selectedIndex = 0.obs; // Selected index

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(),
      selectedFontSize: Fonts.fontSizeSmall,
      unselectedFontSize: Fonts.fontSizeSmall,
      items: [
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage(Images.icHomeOrange),
        //     color: _selectedIndex.value == 0
        //         ? Colors.primary
        //         : Colors.textPlaceHolder,
        //   ),
        //   label: Localizes.home.tr,
        // ),
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage(Images.icAnnouncementOrange),
        //     color: _selectedIndex.value == 1
        //         ? Colors.primary
        //         : Colors.textPlaceHolder,
        //   ),
        //   label: Localizes.announcement.tr,
        // ),
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage(Images.icTimeTableOrange),
        //     color: _selectedIndex.value == 2
        //         ? Colors.primary
        //         : Colors.textPlaceHolder,
        //   ),
        //   label: Localizes.timeTable.tr,
        // ),
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage(Images.icAlbumOrange),
        //     color: _selectedIndex.value == 3
        //         ? Colors.primary
        //         : Colors.textPlaceHolder,
        //   ),
        //   label: Localizes.album.tr,
        // ),
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage(Images.icProfileOrange),
        //     color: _selectedIndex.value == 4
        //         ? Colors.primary
        //         : Colors.textPlaceHolder,
        //   ),
        //   label: Localizes.account.tr,
        // )
      ],
      onTap: onItemTapped,
      selectedItemColor: Colors.primary,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
    );
  }

  /// On tap item bottom bar
  void onItemTapped(int index) {
    onSelectTab(
      TabItem.values[index],
    );
  }

  /// Get current index
  int getCurrentIndex() {
    if (currentTab == TabItem.announcement) {
      _selectedIndex.value = 1;
    } else if (currentTab == TabItem.timetable) {
      _selectedIndex.value = 2;
    } else if (currentTab == TabItem.album) {
      _selectedIndex.value = 3;
    } else if (currentTab == TabItem.account) {
      _selectedIndex.value = 4;
    }
    return _selectedIndex.value;
  }
}
