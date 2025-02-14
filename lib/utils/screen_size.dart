import 'package:get/get.dart';

final double height= Get.height;
final double width= Get.width;
final double heightPercent= Get.height /100;
final double widthPercent= Get.width /100;

double percentageHeight({double value = 0.0}){
  return heightPercent * (value/height *100);
}
double percentageWidth({double value = 0.0}){
  return widthPercent * (value/width *100);
}
