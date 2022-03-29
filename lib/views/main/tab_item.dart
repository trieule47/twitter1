import 'package:flutter/material.dart';

enum TabItem { home, announcement, timetable, album, account }

const Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.announcement: 'announcement',
  TabItem.timetable: 'timetable',
  TabItem.album: 'album',
  TabItem.account: 'account',
};
