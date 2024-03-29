import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.background,
      appBar: this.renderAppBar(),
      body: this.renderBody(),
    );
  }

  /// Render app bar
  Widget renderAppBar({AppBarModel appBarModel}) {
    return AppBar(
      leading: ButtonWidget(
        transparent: true,
        icon: Icon(Icons.arrow_back_outlined),
        onTap: () {},
      ),
      centerTitle: true,
      elevation: Constants.elevation,
      shadowColor: Colors.shadow,
      title: Text(
        appBarModel?.title ?? "Welcome",
        style: CommonStyle.textLargeBold(),
      ),
      titleSpacing: 16,
      actions: [],
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      automaticallyImplyLeading: true,
    );
  }

  /// Render body
  Widget renderBody() {
    return null;
  }
  /// show list new follow
  void ShowListNewFollow(data){
    String text="";
    if(data == null || data == "" || data == []){
      print("data null");
    }else{
      for( var i=0 ; i< data.length; i++){
        text = "${text} ${data[i].name} ;";
      }
      print("chuoi $text");
      Show(text);
    }
  }
  ///show toast
  void Show(value) => Fluttertoast.showToast(
      msg: "He follow ${value}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.primary,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
