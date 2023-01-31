import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:dragtest/drag_getx/widgets/getlistitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleViews extends StatelessWidget {
  const MiddleViews({
    Key? key,
    required this.D,
  }) : super(key: key);
  final DragGetx D;
  @override
    Widget build(BuildContext context) {
    return Obx(()=>Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Container(
                    width: D.itemWidth.value,
                    margin: const EdgeInsets.fromLTRB(0, 1, 5, 3),
                    child: Stack(children: [
                      LayoutBuilder(builder: (context, constraints) {
                        D.leftListHeight.value = constraints.maxHeight;
                       print("left list height === ${D.leftListHeight.value}");
                        return Stack(children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            controller: D.scrollControllerLeft.value,
                            shrinkWrap: true,
                            itemCount: D.itemsLeft.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              TaskIndex location = TaskIndex(CameraRackSides.LEFT.index, index);
                              return GetListItem(D: D,index: index,location: location,list: D.itemsLeft,isVertical: true);
                            }
                          ),
                          (D.itemsLeft.length * D.itemHeight.value) > D.leftListHeight.value
                          ? const SizedBox()
                          : Align(
                            alignment: Alignment.bottomCenter,
                            child: DragTarget(
                              builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                width: D.itemWidth.value,
                                height: D.leftListHeight.value - ((D.itemsLeft.length * D.itemHeight.value) + 10),
                                color: Colors.transparent,
                              ),
                              onWillAccept: (DraggableCard? draggedTask) {
                                return (draggedTask?.fromLocation.boardIndex != 1);
                              },
                              onAccept: (DraggableCard? draggedTask) {
                                  draggedTask?.item.position = D.getListPosition(1)!;
                                  D.getList(1).add(draggedTask!.item);
                                  D.getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                              },
                            ),
                          ),
                        ]);
                      }),
                      !D.isDragStart.value
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.topCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: D.itemWidth.value,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                            print("will accept == Up");
                              D.moveUp(D.scrollControllerLeft.value, D.leftListHeight.value);
                            return false;
                          },
                        ),
                      ),
                      !D.isDragStart.value
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.bottomCenter,
                        child: DragTarget(
                          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                            height: 10,
                            width: D.itemWidth.value,
                            color: Colors.transparent,
                          ),
                          onWillAccept: (DraggableCard? draggedTask) {
                            print("will accept == Down");
                              D.moveDown(D.scrollControllerLeft.value, D.leftListHeight.value);
                            return false;
                          },
                        ),
                      )
                    ]))),
            Container(height: double.infinity, width: 7, color: const Color(0xffD6D6D6)),
            Flexible(
              child: Container(
                  width: D.itemWidth.value,
                  margin: const EdgeInsets.fromLTRB(5, 1, 0, 3),
                  child: Stack(children: [
                    LayoutBuilder(builder: (context, constraints) {
                      D.rightListHeight.value = constraints.maxHeight;
                      return Stack(children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            controller: D.scrollControllerRight.value,
                            shrinkWrap: true,
                            itemCount: D.itemsRight.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              TaskIndex location = TaskIndex(CameraRackSides.RIGHT.index, index);
                              return GetListItem(D: D, index: index,location: location,list: D.itemsRight,isVertical: true);
                            }),
                        (D.itemsRight.length * D.itemHeight.value) > D.rightListHeight.value
                            ? const SizedBox()
                            : Align(
                            alignment: Alignment.bottomCenter,
                            child: DragTarget(
                              builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                                width: D.itemWidth.value,
                                height: D.rightListHeight.value - ((D.itemsRight.length * D.itemHeight.value) + 10),
                                color: Colors.transparent,
                              ),
                              onWillAccept: (DraggableCard? draggedTask) {
                                return (draggedTask!.fromLocation.boardIndex != 2);
                              },
                              onAccept: (DraggableCard? draggedTask) {
                                  draggedTask!.item.position = D.getListPosition(2)!;
                                  D.getList(2).add(draggedTask.item);
                                  D.getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                              },
                            ))
                      ]);
                    }),
                    !D.isDragStart.value
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.topCenter,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 10,
                          width: D.itemWidth.value,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Up");
                            D.moveUp(D.scrollControllerRight.value, D.rightListHeight.value);
                          return false;
                        },
                      ),
                    ),
                    !D.isDragStart.value
                        ? const SizedBox()
                        : Align(
                      alignment: Alignment.bottomCenter,
                      child: DragTarget(
                        builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                          height: 10,
                          width: D.itemWidth.value,
                          color: Colors.transparent,
                        ),
                        onWillAccept: (DraggableCard? draggedTask) {
                          print("will accept == Down");
                            D.moveDown(D.scrollControllerRight.value, D.rightListHeight.value);
                          return false;
                        },
                      ),
                    )
                  ]
                )
              )
            ),
          ],
        ),
      ),
    ));
  }
}