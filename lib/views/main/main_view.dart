import 'package:flutter/material.dart';
import 'package:flutter_app/router/router_config.dart';
import 'package:flutter_app/views/home/home_view.dart';

class MainView extends StatelessWidget {
  MainView({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    switch (title) {
      case RouterConfig.ROUTE_HOME:
        return HomeView();
      default:
        return HomeView();
    }
  }
}
