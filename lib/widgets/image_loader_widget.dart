import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/enums/enums.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/images.dart';

class ImageLoaderWidget extends StatelessWidget {
  final String imageUrl; // Image url
  final BoxFit boxFit; // Container
  final Function renderImageBuilder; // Image builder
  final EdgeInsets marginImage; // Margin container image
  final double heightImage; // Height container image
  final double widthImage; // Width container image
  final BoxShape shape; // Shape
  final ImageLoaderType imageLoaderType; // Image loader type
  final double borderWidth; // Border width
  final double borderRadiusHolder; // Border radius holder

  ImageLoaderWidget({
    @required this.imageUrl,
    @required this.heightImage,
    @required this.widthImage,
    this.renderImageBuilder,
    this.boxFit,
    this.marginImage,
    this.shape,
    this.imageLoaderType: ImageLoaderType.user,
    this.borderWidth,
    this.borderRadiusHolder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey(imageUrl),
      imageUrl: !Utils.isNull(imageUrl) ? imageUrl : "",
      imageBuilder: (context, imageProvider) => renderImageBuilder != null
          ? renderImageBuilder(imageProvider)
          : renderImage(imageProvider),
      placeholder: (context, url) => this.renderImageHolder(),
      errorWidget: (context, url, error) => this.renderImageHolder(),
    );
  }

  /// Render image default
  renderImage(imageProvider) => Container(
        height: heightImage,
        width: widthImage,
        margin: marginImage ?? EdgeInsets.all(Constants.margin8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(
              shape == BoxShape.rectangle ? 0 : Constants.borderRadius),
          shape: shape ?? BoxShape.circle,
        ),
      );

  /// Image builder
  renderImageHolder() => Container(
        height: heightImage,
        width: widthImage,
        margin: marginImage != null ? marginImage : EdgeInsets.all(0),
        // padding: EdgeInsets.all(Constants.marginXXLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(shape == BoxShape.rectangle
              ? borderRadiusHolder ?? 0
              : Constants.borderRadius),
          color: Colors.background,
          shape: shape != null ? shape : BoxShape.rectangle,
          border: Border.all(
            width: borderWidth ?? Constants.borderWidth,
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(imageLoaderType == ImageLoaderType.user
                  ? Images.imgUserDefault
                  : Images.imgNoImage),
            ),
          ],
        ),
      );
}
