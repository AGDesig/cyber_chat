import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/View/on_boarding_screen/controller/page_view_controller.dart';
import 'package:social_app/res/components/app_button.dart';
import 'package:social_app/utils/app_routes.dart';
import 'package:social_app/utils/app_strings.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});

  // Use GetX's dependency management to initialize the controller
  final PageViewController pVController = Get.put(PageViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pVController.pageViewController.value,
                    onPageChanged: pVController.handlePageViewChanged,
                    itemCount: 3, // The number of pages you want to display
                    itemBuilder: (context, index) {
                      return Container(
                        child:
                          Align(alignment: Alignment.bottomCenter,child: pageDetail(index)),
                      );
                    },
                  ),
                ),
                SizedBox(height: Get.height/100 *4,),
                Container(
                  decoration: BoxDecoration(color: Colors.blueGrey,shape: BoxShape.rectangle,borderRadius: BorderRadius.all(Radius.circular(100))),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3,
                          (indicatorIndex) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: pVController.currentPageIndex.value == indicatorIndex
                              ? Colors.black
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height/100 *3,),
             pVController.currentPageIndex.value>1?appButton(text: getStarted,onTap: () => pVController.onNextPage(pVController.currentPageIndex.value),haveSize: false,padding: EdgeInsets.all(10),margin: EdgeInsets.symmetric(horizontal: 20)):Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appButton(text: skip,onTap: () => Get.toNamed(AppRoutes.login,),color: Colors.black,haveSize: true,alignment: Alignment.center),
                    appButton(text: next,onTap: () => pVController.onNextPage(pVController.currentPageIndex.value),haveSize: true),
                  ],
                ),
                SizedBox(height: Get.height/100 *5,),
              ],
            ),
          ),
        );
      }),
    );
  }


  Widget pageDetail(int index,{String? text,String? subTex5}) {

    switch(index){
      case 0:
        return
          highlightWidget(text: "Sharing Your Idea",subText: "Duis aute irure dolor in reprehenderit in voluptate velitaasdasdasd");
      case 1:
        return
          highlightWidget(text: "Connect with Community",subText: "Duis aute irure dolor in reprehenderit in voluptate velitaasdasdasd");
      case 2:
        return
          highlightWidget(text:"Explore in Slide App",subText: "Duis aute irure dolor in reprehenderit in voluptate velitaasdasdasd");
      default:
     return   SizedBox();
    }
  }

  Widget highlightWidget({String text= "", String subText = ""}) {
    return Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,children: [
          Text(text,textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          Text(subText,textAlign: TextAlign.center, style: TextStyle(fontSize: 18,)),

        ],);
  }
}
