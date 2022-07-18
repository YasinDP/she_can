import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TabItem(
      {required this.selected,
      required this.iconData,
      required this.title,
      required this.callbackFunction});

  final String title;
  final IconData iconData;
  final bool selected;
  final Function callbackFunction;

  @override
  TabItemState createState() => TabItemState();
}

class TabItemState extends State<TabItem> {
  static const double iconOff = -3;
  static const double iconOn = 0;
  static const double textOff = 3;
  static const double textOn = 1;
  static const double alphaOff = 0;
  static const double alphaOn = 1;
  static const int animDuration = 300;
  static const Color purple = Color(0xFF8c77ec);

  double iconYAlign = iconOn;
  double textYAlign = textOff;
  double iconAlpha = alphaOn;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? iconOff : iconOn;
      textYAlign = (widget.selected) ? textOn : textOff;
      iconAlpha = (widget.selected) ? alphaOff : alphaOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: const Duration(milliseconds: animDuration),
                alignment: Alignment(0, textYAlign),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 10),
                  ),
                )),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: animDuration),
              curve: Curves.easeIn,
              alignment: Alignment(0, iconYAlign),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: animDuration),
                opacity: iconAlpha,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                  alignment: const Alignment(0, 0),
                  icon: Icon(
                    widget.iconData,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    widget.callbackFunction();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
