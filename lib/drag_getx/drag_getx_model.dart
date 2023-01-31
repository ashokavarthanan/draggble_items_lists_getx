
/// custom data
class CustomData {
  int id;
  String position;
  int row;

  CustomData( {required this.id,
    required this.position,
    required this.row,
    });
}

/// for maintain card data
class TaskIndex {
  final int boardIndex;
  final int listIndex;

  TaskIndex(this.boardIndex, this.listIndex);

  bool operator (TaskIndex other) {
    return boardIndex == other.boardIndex && listIndex == other.listIndex;
  }
}

///DraggableCard class
class DraggableCard {
  TaskIndex fromLocation;
  CustomData item;
  int itemPos;

  DraggableCard(this.fromLocation, this.item, {required this.itemPos});
}