import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:dragtest/drag_getx/widgets/getlistitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopViews extends StatelessWidget {
  const TopViews({
    Key? key,
    required this.D,
  }) : super(key: key);

  final DragGetx D;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          D.topListWidth.value = constraints.maxWidth;
          print("top list length == ${D.bottomListWidth.value}");
          return Stack(
            children: [
              Top(D: D,),
              (D.itemsTop.length * D.itemWidth.value) > D.topListWidth.value
                ? const SizedBox()
                : Align(
                alignment: Alignment.centerRight,
                child: DragTarget(
                  builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
                    height: 100,
                    width: D.topListWidth.value - ((D.itemsTop.length * D.itemWidth.value) + 10),
                    color: Colors.transparent,
                  ),
                  onWillAccept: (DraggableCard? draggedTask) {
                    return (draggedTask?.fromLocation.boardIndex != 0);
                  },
                  onAccept: (DraggableCard? draggedTask) {
                      draggedTask?.item.position = D.getListPosition(0)!;
                      D.getList(0).add(draggedTask!.item);
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
          alignment: Alignment.topRight,
          child: DragTarget(
            builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
              height: 100,
              width: 10,
              color: Colors.transparent,
            ),
            onWillAccept: (DraggableCard? draggedTask) {
              print("will accept == Right");
                D.moveRight(D.scrollControllerTop.value, D.topListWidth.value);
              return false;
            },
          ),
        ),
        !D.isDragStart.value
            ? const SizedBox()
            : Align(
          alignment: Alignment.topLeft,
          child: DragTarget(
            builder: (context, List<DraggableCard?> candidateData, rejectedData) => Container(
              height: 100,
              width: 10,
              color: Colors.transparent,
            ),
            onWillAccept: (DraggableCard? draggedTask) {
              print("will accept == Left");
                D.moveLeft(D.scrollControllerTop.value, D.topListWidth.value);
              return false;
            },
          ),
        ),
      ],
    ));
  }
}
class Top extends StatelessWidget {
  const Top({
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
        controller: D.scrollControllerTop.value,
        shrinkWrap: true,
        itemCount: D.itemsTop.length + 1,
        /// for dummy space at last
        itemBuilder: (BuildContext context, int index) {
          TaskIndex location = TaskIndex(CameraRackSides.TOP.index, index);
          return GetListItem(D: D, index: index,location: location,list:D.itemsTop,isVertical: false);
        },
      ),
    );
  }
}
