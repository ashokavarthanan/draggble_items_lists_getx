import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:dragtest/drag_getx/widgets/getlistitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomViews extends StatelessWidget {
  const BottomViews({
    Key? key,
    required this.D,
  }) : super(key: key);

  final DragGetx D;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(children: [
      LayoutBuilder(builder: (context, constraints) {
        D.bottomListWidth.value = constraints.maxWidth;
        print("bottom list length == ${D.bottomListWidth.value}");
        return Stack(
          children: [
            Bottom(D: D),
            (D.itemsBottom.length * D.itemWidth.value) > D.bottomListWidth.value
              ? const SizedBox()
              : Align(
              alignment: Alignment.centerRight,
              child: DragTarget(
                builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                  height: D.itemHeight.value,
                  width: D.bottomListWidth.value - ((D.itemsBottom.length * D.itemWidth.value) - 10),
                  color: Colors.transparent,
                ),
                onWillAccept: (DraggableCard? draggedTask) {
                  print("Will accept : bottom : space");
                  return (draggedTask!.fromLocation.boardIndex != 3);
                },
                onAccept: (DraggableCard? draggedTask) {
                    draggedTask!.item.position = D.getListPosition(3)!;
                    D.getList(3).add(draggedTask.item);
                    D.getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
                },
              ),
            ),
          ],
        );
      }),
      !D.isDragStart.value
          ? const SizedBox()
          : Align(
        alignment: Alignment.bottomRight,
        child: DragTarget(
          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
            height: 100,
            width: 10,
            color: Colors.transparent,
          ),
          onWillAccept: (DraggableCard? draggedTask) {
            print("will accept == Right");
              D.moveRight(D.scrollControllerBottom.value, D.bottomListWidth.value);
            return false;
          },
        ),
      ),
      !D.isDragStart.value
          ? const SizedBox()
          : Align(
        alignment: Alignment.bottomLeft,
        child: DragTarget(
          builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
            height: 100,
            width: 10,
            color: Colors.transparent,
          ),
          onWillAccept: (DraggableCard? draggedTask) {
            print("will accept == Left");
              D.moveLeft(D.scrollControllerBottom.value, D.bottomListWidth.value);
            return false;
          },
        ),
      )
    ]));
  }
}
class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
    required this.D,
  }) : super(key: key);
  final DragGetx D;
  @override
    Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 2, 0, 1),
      height: D.itemHeight.value,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        controller: D.scrollControllerBottom.value,
        itemCount: D.itemsBottom.length + 1,
        // for dummy space at last
        itemBuilder: (BuildContext context, int index) {
          TaskIndex location = TaskIndex(CameraRackSides.BOTTOM.index, index);
          return GetListItem(D: D,index: index, location: location, list: D.itemsBottom, isVertical: false);
        }
      ),
    );
  }
}
