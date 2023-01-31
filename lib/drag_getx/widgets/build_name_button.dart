import 'package:dragtest/drag_getx/drag_getx_c.dart';
import 'package:flutter/material.dart';

class BuildSizedNamedButton extends StatelessWidget {
  const BuildSizedNamedButton({
    Key? key,
    required this.D,
    required this.url,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final DragGetx D;
  final String url;
  final String name;
  final void Function() onPressed;
  @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: D.itemWidth.value,
        height: D.itemHeight.value,
        // child: new RaisedButton(
        /*color: Colors.deepOrangeAccent,*/
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(width: 0, color: Colors.grey),
            borderRadius: BorderRadius.zero,
          ),
          child:  Container(
            child: Center(child: Text(name,style: const TextStyle(color: Colors.white),)),
          ),
        ),
      );
    }
}
