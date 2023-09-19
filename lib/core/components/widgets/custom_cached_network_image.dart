import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  CustomCachedNetworkImage(
      {Key? key,
      required this.imageUrl,
      required this.imageBuilder,
      this.isShowProgressIndicator = true})
      : super(key: key);

  String imageUrl;
  Widget Function(BuildContext context, ImageProvider<Object> imageProvider)?
      imageBuilder;
  bool isShowProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: imageBuilder,
        errorWidget: (context, url, error) {
          log(error.toString());
          return const Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, progress) =>
            isShowProgressIndicator
                ? SizedBox(
                    height: context.getHeight * .02,
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )),
                  )
                : const SizedBox.shrink());
  }
}

/*class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.isProgressIndicator = false,
      this.fit})
      : super(key: key);
  final String imageUrl;
  final bool isProgressIndicator;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider, fit: fit ?? BoxFit.fill)),
          )),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          isProgressIndicator == true
              ? CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  value: downloadProgress.progress)
              : const SizedBox(),
      /* progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          backgroundColor: MyColors.primaryColorList.last,
                          color: MyColors.primaryColorList.first,
                          value: downloadProgress.progress),*/
      // placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}*/
