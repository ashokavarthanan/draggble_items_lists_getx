    import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:flutter/material.dart';

/// add extra space at end of list
class WidgetForExtraSpace extends StatelessWidget {
  const WidgetForExtraSpace({
    Key? key,
    required this.D,
    required this.boardIndex,
    required this.isTop,
  }) : super(key: key);
  final DragGetx D;
  final int boardIndex;
  final bool isTop;
  @override
    Widget build(BuildContext context) {
      return Visibility(
        visible: D.getVisibilitySpace(boardIndex) ?? true,
        child: Container(
          child: DragTarget(
            builder: (context, List<DraggableCard?> candidateData, rejectedData) {
              return Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: D.itemHeight.value,
                    width: D.itemWidth.value,
                  ),
              );
            }, 
            onWillAccept: (DraggableCard? draggedTask) {
              print("Will accept  extra trailing space");
              return (draggedTask?.fromLocation.boardIndex != boardIndex);
            }, 
            onAccept: (DraggableCard? draggedTask) {
                print(" from board : $boardIndex");
                // set position
                draggedTask!.item.position = D.getListPosition(boardIndex)!;
                if (isTop) {
                  D.getList(boardIndex).insert(0, draggedTask.item);
                } else {
                  D.getList(boardIndex).add(draggedTask.item);
                }
                D.getList(draggedTask.fromLocation.boardIndex).removeAt(draggedTask.fromLocation.listIndex);
            }
          ),
        ),
      );
    }
}
