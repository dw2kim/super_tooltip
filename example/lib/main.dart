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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Builder(
              builder: (BuildContext buttonContext) {
                return CompositedTransformTarget(
                  link: link,
                  child: ElevatedButton(
                    onPressed: () => onTap(buttonContext),
                    child: Text('press me'),
                  ),
                );
              },
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
      targetLinkOffset: Offset(0, -50),
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

    tooltip!.show(targetContext);
  }
}
