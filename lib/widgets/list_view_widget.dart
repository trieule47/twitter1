import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter_app/enums/enums.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/images.dart';
import 'package:get/get.dart';

class ListViewWidget extends StatefulWidget {
  final int itemCount; // Item count
  final Widget Function(BuildContext context, int index)
      itemBuilder; // Item builder
  final Future<void> Function() onLoadMore; // On load more
  final bool enableLoadMore; // Enable load more
  final Axis scrollDirection; // Scroll direction
  final ScrollPhysics physics; // Scroll physics
  final Widget listHeaderWidget;
  final Decoration decoration; // Box decoration
  final EdgeInsetsGeometry padding; // Padding
  final EdgeInsetsGeometry margin; // Margin
  final String textForEmpty; // Text for empty
  final String titleList; // Text title list
  final bool shrinkWrap; // Shrink warp
  final Widget buttonForEmpty; // Button for empty
  final SliverGridDelegate gridDelegate; // Grid delegate for grid view
  final Widget tapList; // Tap list
  final bool reverse; // Reverse

  ListViewWidget({
    @required this.itemCount,
    @required this.itemBuilder,
    this.onLoadMore,
    this.enableLoadMore: false,
    this.scrollDirection: Axis.vertical,
    this.physics: const AlwaysScrollableScrollPhysics(),
    this.listHeaderWidget,
    this.decoration,
    this.padding,
    this.margin,
    this.textForEmpty,
    this.titleList,
    this.shrinkWrap: false,
    this.buttonForEmpty,
    this.gridDelegate,
    this.tapList,
    this.reverse,
  });

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final ScrollController controller = ScrollController();
  final GlobalKey _keyHeader = GlobalKey();
  var headerHeight = 0.0.obs;
  var loadMoreType = LoadMoreType.idle;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.headerHeight.value = _keyHeader.currentContext.size.height;
    });
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var maxHeight = constraints.maxHeight;
          return ListView(
            controller: controller,
            physics: widget.physics,
            cacheExtent: 1000.0,
            shrinkWrap: widget.shrinkWrap,
            reverse: widget.reverse ?? false,
            children: [
              renderListHeaderWidget(),
              renderListBodyWidget(maxHeight),
              renderListFooterWidget(),
            ],
          );
        },
      ),
    );
  }

  /// Render list body widget
  renderListBodyWidget(double maxHeight) {
    if (widget.itemCount > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !Utils.isNull(widget.titleList)
              ? Padding(
                  padding: EdgeInsets.only(
                    right: Constants.padding16,
                    left: Constants.padding16 + Constants.padding,
                    top: Constants.padding16,
                  ),
                  child: Text(
                    widget.titleList,
                    style: CommonStyle.textMediumBold(),
                  ),
                )
              : Container(),
          !Utils.isNull(widget.tapList) ? widget.tapList : Container(),
          Container(
            padding: widget.padding,
            margin: widget.margin,
            decoration: widget.decoration,
            child: renderChild(),
          ),
        ],
      );
    } else {
      return Obx(
        () => Container(
          constraints: BoxConstraints(
            minHeight: maxHeight - this.headerHeight.value,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.imgError),
              SizedBox(height: Constants.padding16),
              Text(widget.textForEmpty ?? Localizes.noData.tr),
              SizedBox(height: Constants.padding16 * 4 + Constants.margin12),
              widget.buttonForEmpty ?? Container(),
            ],
          ),
        ),
      );
    }
  }

  /// Render child
  renderChild() {
    if (Utils.isNull(widget.gridDelegate)) {
      return ListView.builder(
        scrollDirection: widget.scrollDirection,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, index);
        },
        itemCount: widget.itemCount,
      );
    } else {
      return GridView.builder(
        scrollDirection: widget.scrollDirection,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: widget.gridDelegate,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, index);
        },
        itemCount: widget.itemCount,
        shrinkWrap: true,
      );
    }
  }

  /// Render list header widget
  renderListHeaderWidget() {
    return Container(
      key: _keyHeader,
      child: widget.listHeaderWidget ?? Container(),
    );
  }

  /// Render list footer widget
  renderListFooterWidget() {
    return widget.enableLoadMore
        ? Container(
            padding: EdgeInsets.all(Constants.padding16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }

  /// Scroll listener
  void scrollListener() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse &&
        controller.position.extentAfter < 500 &&
        widget.enableLoadMore &&
        loadMoreType == LoadMoreType.idle) {
      onLoadMore();
    }
  }

  /// On load more
  Future<void> onLoadMore() async {
    loadMoreType = LoadMoreType.isLoading;
    await widget.onLoadMore();
    loadMoreType = LoadMoreType.idle;
  }
}
