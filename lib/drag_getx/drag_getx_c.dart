
// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
enum CameraRackSides { TOP, LEFT, RIGHT, BOTTOM }
class DragGetx extends GetxController{
  
  final scrollControllerTop = ScrollController().obs;
  final scrollControllerBottom = ScrollController().obs;
  final scrollControllerLeft = ScrollController().obs;
  final scrollControllerRight = ScrollController().obs;
  /// Lists
  final itemsTop = <CustomData>[].obs;
  final itemsLeft = <CustomData>[].obs;
  final itemsRight = <CustomData>[].obs;
  final itemsBottom = <CustomData>[].obs;

  final topListWidth = 0.0.obs; 
  final bottomListWidth = 0.0.obs; 
  final leftListHeight = 0.0.obs; 
  final rightListHeight = 0.0.obs; 

  final isDragStart = false.obs;
  final isShowExtraSpaceTop = false.obs;
  final isShowExtraSpaceLeft = false.obs;
  final isShowExtraSpaceRight = false.obs;
  final isShowExtraSpaceBottom = false.obs;

  final itemWidth = 50.00.obs;
  final itemHeight = 100.00.obs;

  final KEY_TOP = 'top';
  final KEY_LEFT = 'left';
  final KEY_RIGHT = 'right';
  final KEY_BOTTOM = 'bottom';

  moveUp(ScrollController scrollController, double height) {
    scrollController.animateTo(scrollController.offset - height, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }
  moveDown(ScrollController scrollController, double height) {
    scrollController.animateTo(scrollController.offset + height, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }
  moveLeft(ScrollController scrollController, double width) {
    scrollController.animateTo(scrollController.offset - width, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }
  moveRight(ScrollController scrollController, double width) {
    scrollController.animateTo(scrollController.offset + width, curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  Future<void> onInit() async {
      itemsTop.value =[
        CustomData(id: 1 , position: "top" ,row: 1 ),
        CustomData(id: 2 , position: "top" ,row: 1 ),
        CustomData(id: 3 , position: "top" ,row: 1 ),
        CustomData(id: 4 , position: "top" ,row: 1 ),
      ];
      itemsBottom.value =[
        CustomData(id: 1 , position: "bottom" ,row: 1 ),
        CustomData(id: 2 , position: "bottom" ,row: 1 ),
        CustomData(id: 3 , position: "bottom" ,row: 1 ),
      ];
      itemsRight.value =[
        CustomData(id: 1 , position: "right" ,row: 1 ),
        CustomData(id: 2 , position: "right" ,row: 1 ),
        CustomData(id: 3 , position: "right" ,row: 1 ),
        CustomData(id: 4 , position: "right" ,row: 1 ),
        CustomData(id: 5 , position: "right" ,row: 1 ),
      ];
      itemsLeft.value =[
        CustomData(id: 1 , position: "left" ,row: 1 ),
        CustomData(id: 2 , position: "left" ,row: 1 ),
      ];
    super.onInit();
  }

  // get list from index
  RxList<CustomData> getList(int boardIndex) {
    switch (boardIndex) {
      case 0:
        return itemsTop;
      case 1:
        return itemsLeft;
      case 2:
        return itemsRight;
      case 3:
        return itemsBottom;
    }
    return itemsBottom;
  }
    // get list position [index]
    getListPosition(int index) {
      switch (index) {
        case 0:
          return KEY_TOP;
        case 1:
          return KEY_LEFT;
        case 2:
          return KEY_RIGHT;
        case 3:
          return KEY_BOTTOM;
      }
    }
    // accept dragged item
    doAcceptCard(DraggableCard? draggedTask, TaskIndex location) {
        isDragStart.value = false;
        isShowExtraSpaceTop.value = false;
        isShowExtraSpaceLeft.value = false;
        isShowExtraSpaceRight.value = false;
        isShowExtraSpaceBottom.value = false;
      // from other location
      if (location.boardIndex != draggedTask!.fromLocation.boardIndex) {
          var toList = getList(location.boardIndex);
          var fromList = getList(draggedTask.fromLocation.boardIndex);
          print(" from board : ${draggedTask.fromLocation.boardIndex}");
          // set positions
          draggedTask.item.position = getListPosition(location.boardIndex)!;
          toList.insert(location.listIndex, draggedTask.item);
          fromList.removeAt(draggedTask.fromLocation.listIndex);
      } else {
        // from same list
          var tmpList = getList(location.boardIndex);
          if (tmpList.remove(draggedTask.item)) tmpList.insert(location.listIndex, draggedTask.item);
      }
    }
    /// get specif visible list space
    getVisibilitySpace(int boardIndex) {
      switch (boardIndex) {
        case 0:
          return isShowExtraSpaceTop.value;
        case 1:
          return isShowExtraSpaceLeft.value;
        case 2:
          return isShowExtraSpaceRight.value;
        case 3:
          return isShowExtraSpaceBottom.value;
      }
    }

}