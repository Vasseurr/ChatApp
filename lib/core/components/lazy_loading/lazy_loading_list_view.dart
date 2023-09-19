import 'package:flutter/material.dart';

import 'lazy_loading_list_view_mixin.dart';

class LazyLoadingListView<T> extends StatefulWidget {
  LazyLoadingListView(
      {super.key,
      required this.itemList,
      required this.itemWidget,
      required this.hasMoreItems,
      required this.fetchItems});

  List<T> itemList;
  Widget Function(int index) itemWidget;
  bool hasMoreItems;
  Function() fetchItems;
  @override
  State<LazyLoadingListView> createState() => _LazyLoadingListViewState();
}

class _LazyLoadingListViewState extends State<LazyLoadingListView>
    with LazyLoadingListViewMixin {
  @override
  void initState() {
    super.initState();
    itemList = widget.itemList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.hasMoreItems ? itemList.length + 1 : itemList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index >= itemList.length) {
          if (!isLoading) {
            fetchItems(widget.fetchItems);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return widget.itemWidget(index);
      },
    );
  }
}
