import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/widgets/bottomview.dart';
import 'package:dragtest/drag_getx/widgets/middleview.dart';
import 'package:dragtest/drag_getx/widgets/topview.dart';
// import 'package:dragtest/drag_getx/drag_getx_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DragGetxIndex extends StatelessWidget {
  DragGetxIndex({super.key});
  final D = Get.put(DragGetx());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: const Color(0xffFFFFFF),
                padding: const EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopViews(D: D),
                    Container(margin: const EdgeInsets.fromLTRB(0, 2, 0, 0), height: 7, color: const Color(0xffD6D6D6)),
                    MiddleViews(D: D,),
                    Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 2), height: 7, color: const Color(0xffD6D6D6)),
                    BottomViews(D: D)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

