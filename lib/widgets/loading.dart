import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_progressIndicator.dart';

/// For Loading Widget

Widget kCustomFooter(context) => CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("Pull to Load More");
        } else if (mode == LoadStatus.loading) {
          body = progressIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Fail");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("Release To Rolad More");
        } else {
          body = Text("No Data");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
