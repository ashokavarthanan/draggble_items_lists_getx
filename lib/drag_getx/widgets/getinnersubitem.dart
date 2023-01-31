    import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:dragtest/drag_getx/widgets/build_name_button.dart';
import 'package:flutter/material.dart';

/// get inner sub item
class GetInnerSubItem extends StatelessWidget {
  const GetInnerSubItem({
    Key? key,
    required this.D,
    required this.index,
    required this.location,
    required this.list,
    required this.isVertical,
  }) : super(key: key);
  final DragGetx D;
  final int index;
  final TaskIndex location;
  final List<CustomData> list;
  final bool isVertical;
  @override
    Widget build(BuildContext context) {
      return Padding(
        padding: (isVertical ? EdgeInsets.fromLTRB(0, index == 0 ? 0 : 2, 0, 2) : EdgeInsets.fromLTRB(index == 0 ? 0 : 2, 0, 2, 0)),
        child: DragTarget(
          builder: (context, List<DraggableCard?> candidateData, rejectedData) {
            return Container(
              child: LongPressDraggable(
                  feedback: Transform.rotate(
                    angle: 0, // 5 degrees to radians  0.0872665,
                    child: BuildSizedNamedButton(D: D,  url: "", name: '${list[index].id}', onPressed: () {}),
                  ),
                  childWhenDragging: BuildSizedNamedButton(D: D,  url: "", name: '', onPressed: () {}),
                  data: DraggableCard(location, list[index], itemPos: index),
                  onDragStarted: () {
                      D.isDragStart.value = true;
                  },
                  onDragCompleted: () {
                      D.isDragStart.value = false;
                      D.isShowExtraSpaceTop.value = false;
                      D.isShowExtraSpaceLeft.value = false;
                      D.isShowExtraSpaceRight.value = false;
                      D.isShowExtraSpaceBottom.value = false;
                  },
                  child: BuildSizedNamedButton(D: D,  url: "", name: '${list[index].id}', onPressed: () {})),
            );
          },
          onWillAccept: (DraggableCard? draggedTask) {
            print("Top WillAccept view data======= ${location.listIndex} Dragged on index ====${draggedTask!.fromLocation.listIndex}");
            print("location.boardIndex ${location.boardIndex}=== fromLocation.boardIndex ${draggedTask.fromLocation.boardIndex}");
            if (location.boardIndex != draggedTask.fromLocation.boardIndex) {
              switch (location.boardIndex) {
                case 0:
                  D.isShowExtraSpaceTop.value = true;
                  break;
                case 1:
                  D.isShowExtraSpaceLeft.value = true;
                  break;
                case 2:
                  D.isShowExtraSpaceRight.value = true;
                  break;
                case 3:
                  D.isShowExtraSpaceBottom.value = true;
                  break;
              }
            }
            return true;
          },
          onAccept: (DraggableCard? draggedTask) {
            print("inside accept top=== ${draggedTask!.itemPos}");
            D.doAcceptCard(draggedTask, location);
          },
        ),
      );
    }
}
