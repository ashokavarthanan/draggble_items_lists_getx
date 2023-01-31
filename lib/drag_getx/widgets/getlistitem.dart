import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:dragtest/drag_getx/drag_getx_model.dart';
import 'package:dragtest/drag_getx/widgets/getinnersubitem.dart';
import 'package:dragtest/drag_getx/widgets/widgetextraspace.dart';
import 'package:flutter/material.dart';

class GetListItem extends StatelessWidget {
  const GetListItem({
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
      if (index == list.length) {
        return WidgetForExtraSpace(D: D,boardIndex: location.boardIndex,isTop: false);
      }
      if (index == 0) {
        return isVertical
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [WidgetForExtraSpace(D: D,boardIndex: location.boardIndex,isTop: true), GetInnerSubItem(D: D,index: index, location: location,list: list,isVertical: isVertical)],
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [WidgetForExtraSpace(D: D,boardIndex: location.boardIndex,isTop: true), GetInnerSubItem(D: D,index: index, location: location,list: list,isVertical: isVertical)],
        );
      }
      return GetInnerSubItem(D: D,index: index, location: location,list: list,isVertical: isVertical);
    }
}
