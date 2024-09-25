

import 'package:get/get.dart';

class NavigationBarController extends GetxController{

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    update();
  }
}