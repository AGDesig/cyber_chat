import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/utils/app_routes.dart';

class PageViewController extends GetxController {
  final Rx<PageController> _pageViewController = PageController().obs;
  final RxInt _currentPageIndex = 0.obs;
  Rx<PageController> get pageViewController => _pageViewController;
  RxInt get currentPageIndex => _currentPageIndex;

  // Updated handlePageViewChanged to update index on all platforms
  void handlePageViewChanged(int currentPageIndex) {
    _currentPageIndex.value = currentPageIndex;
  }

  void onNextPage(int index) {
    if (index < 2 ) {
      // First, update the current page index
      if(_currentPageIndex.value !=2){
        _currentPageIndex.value = index + 1;
      }

      //Then, animate to the next page after the index is updated
      pageViewController.value.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      Get.toNamed(AppRoutes.login);
    }
  }


  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}
