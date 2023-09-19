import 'package:flutter/material.dart';

import 'lazy_loading_list_view.dart';

mixin LazyLoadingListViewMixin<T> on State<LazyLoadingListView> {
  bool hasMoreItems = true;
  bool isLoading = false;
  List<T> itemList = [];

  Future<void> fetchItems(Function() function) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = true;
      });
    });
    await Future.delayed(const Duration(seconds: 1), () {
      print("object");
      function();
      /*if (itemList.length >= 250) {
        setState(() {
          hasMoreItems = false;
        });
      }*/
      setState(() {
        isLoading = false;
      });
    });
  }
}
