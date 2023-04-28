import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/configs/app_configs.dart';

typedef BuilderCallback = Widget? Function(BuildContext context, int index);

class AppListingComponent<T> extends StatefulWidget {
  /// declare controller for list
  final ScrollController? controller;

  /// enable pull to refresh: true/false
  final bool enableRefresh;

  /// enable load more: true/false
  final bool enableLoadMore;

  /// is loading
  final bool isLoading;

  /// is load more
  final bool isLoadMore;

  /// onRefresh
  final VoidCallback? onRefresh;

  /// onLoadMore
  final VoidCallback? onLoadMore;

  /// item list
  final List<T> items;

  /// return widget that call back index
  final BuilderCallback builder;

  /// return separated widget that call back item
  final Widget? separatedWidget;

  /// loading widget, default is cupertino loading
  final Widget? loadingWidget;

  /// load more widget, default is cupertino loading
  final Widget? loadMoreWidget;

  /// return widget when items empty
  final Widget? emptyWidget;

  /// primary
  final bool? primary;

  /// auto dispose controller
  final bool autoDispose;

  const AppListingComponent({
    Key? key,
    this.controller,
    required this.items,
    required this.builder,
    this.enableLoadMore = false,
    this.enableRefresh = false,
    this.loadingWidget,
    this.onRefresh,
    this.onLoadMore,
    this.primary,
    this.autoDispose = true,
    this.loadMoreWidget,
    this.separatedWidget,
    this.emptyWidget,
    this.isLoading = false,
    this.isLoadMore = false,
  }) : super(key: key);

  @override
  State<AppListingComponent> createState() => _AppListingComponentState();
}

class _AppListingComponentState extends State<AppListingComponent> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? ScrollController();
    if (widget.onLoadMore != null && widget.enableLoadMore) {
      _controller.addListener(_loadMore);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppListingComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.isLoadMore != widget.isLoadMore) ||
        (oldWidget.isLoading != widget.isLoading)) {
      setState(() {});
    }
  }

  void _loadMore() {
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.maxScrollExtend) {
      widget.onLoadMore?.call();
    }
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      if (widget.onLoadMore != null) {
        _controller.removeListener(_loadMore);
      }
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _loadingWidget();
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          if (widget.enableRefresh && widget.onRefresh != null) {
            widget.onRefresh?.call();
          }
        },
        child: widget.items.isEmpty
            ? _emptyWidget()
            : ListView.separated(
                controller: _controller,
                primary: widget.primary,
                itemBuilder: widget.builder,
                separatorBuilder: (context, index) {
                  if (widget.separatedWidget != null) {
                    if (widget.isLoadMore) {
                      return _loadMoreWidget();
                    }
                    return widget.separatedWidget!;
                  }
                  return const SizedBox();
                },
                itemCount: widget.items.length,
              ),
      );
    }
  }

  Widget _emptyWidget() {
    if (widget.emptyWidget != null) {
      return widget.emptyWidget!;
    }
    return const Center(
      child: Text('list empty'),
    );
  }

  Widget _loadMoreWidget() {
    if (widget.loadMoreWidget != null) {
      return widget.loadMoreWidget!;
    }
    return const CupertinoActivityIndicator(
      radius: 15,
    );
  }

  Widget _loadingWidget() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }
    return const CupertinoActivityIndicator(
      radius: 40,
    );
  }
}
