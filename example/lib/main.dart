import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SuperTooltip? tooltip;

  final LayerLink link = LayerLink();
  final buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CompositedTransformTarget(
                  link: link,
                  child: Builder(
                    builder: (BuildContext buttonContext) {
                      return ElevatedButton(
                        key: buttonKey,
                        onPressed: () => onTap(buttonContext),
                        child: Text('dont press me'),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('press me'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext targetContext) {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.down,
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
      content: Material(
        child: Text(
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
          softWrap: true,
        ),
      ),
    );
    tooltip!.show(targetContext,
        targetCenter: Offset(buttonKey.globalPaintBounds.width / 2,
            buttonKey.globalPaintBounds.height / 2));
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
