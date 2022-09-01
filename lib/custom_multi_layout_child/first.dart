import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Directionality(
        // TRY THIS: Try changing the direction here and hot-reloading to
        // see the layout change.
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(),
          body: const ExampleWidget(),
        ),
      ),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  final train = 'assets/2D/train/train1.png';
  final driver = 'assets/2D/parts/panel_driver_l.png';
  final ci = 'assets/2D/parts/ci_on.png';
  final panelOff = 'assets/2D/parts/hvac_off.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: CustomMultiChildLayout(
        delegate: _CascadeLayoutDelegate(),
        children: [
              LayoutId(id: 1, child: Image.asset(train)),
              LayoutId(id: 2, child: Image.asset(driver)),
              LayoutId(id: 3, child: Image.asset(ci)),
              LayoutId(id: 4, child: Image.asset(panelOff)),
        ],
      ),
    );
  }
}

/// Lays out the children in a cascade, where the top corner of the next child
/// is a little above (`overlap`) the lower end corner of the previous child.
///
/// Will relayout if the text direction changes.
class _CascadeLayoutDelegate extends MultiChildLayoutDelegate {

  @override
  Size getSize(BoxConstraints constraints) {
    return const Size(350, 200);
  }

  // Perform layout will be called when re-layout is needed.
  @override
  void performLayout(Size size) {
      late final Size one;
      late final Size two;
      late final Size three;
      if (hasChild(1)) {
        one = layoutChild(1, const BoxConstraints.expand(width: 350, height: 200));

      }
      if (hasChild(2)) {
        print(one.toString());
        two = layoutChild(2, BoxConstraints.loose(size/3));
        const double horizontal = 38;
        const double vertical = 80;
        positionChild(2, const Offset(horizontal, vertical));
      }
      if (hasChild(3)) {
        three = layoutChild(3, BoxConstraints.loose(size/8));
        final horizontal = one.width / 2;
        final vertical = one.height * 0.7;
        positionChild(3, Offset(horizontal, vertical));
      }

      if (hasChild(4)) {
        layoutChild(4, BoxConstraints.loose(size/3.8));
        const double horizontal = 60;
        const double vertical = 25;
        positionChild(4, const Offset(horizontal, vertical));
      }
  }

  // shouldRelayout is called to see if the delegate has changed and requires a
  // layout to occur. Should only return true if the delegate state itself
  // changes: changes in the CustomMultiChildLayout attributes will
  // automatically cause a relayout, like any other widget.
  @override
  bool shouldRelayout(_CascadeLayoutDelegate oldDelegate) {
    return true;
  }
}
