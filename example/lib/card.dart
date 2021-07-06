import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class MyCard extends StatefulWidget {
  final int index;
  const MyCard(this.index, {Key? key}) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  SuperTooltip? tooltip;
  final LayerLink link = LayerLink();

  BuildContext? targetContext;
  final containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: containerKey,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('filler'),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext buttonContext) {
                      targetContext = buttonContext;
                      return CompositedTransformTarget(
                        link: link,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.height),
                            onPressed: onTap,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    final box = targetContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(box.paintBounds.topLeft);
    final xPos = offset.dx;
    final yPos = offset.dy;

    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.left,
      arrowTipDistance: 15.0,
      arrowBaseWidth: 40.0,
      arrowLength: 40.0,
      borderColor: Colors.green,
      borderWidth: 5.0,
      showCloseButton: ShowCloseButton.none,
      hasShadow: false,
      dismissOnTapOutside: false,
      containsBackgroundOverlay: false,
      minimumOutSidePadding: 20,
      targetLink: link,
      animationDuration: 0,
      tooltipOffset: Offset(-xPos, -yPos),
      content: Material(
        child: Text(
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
          softWrap: true,
        ),
      ),
    );
    tooltip!.show(targetContext!);
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return renderObject!.paintBounds.shift(Offset(0, 0));
    }
  }
}
