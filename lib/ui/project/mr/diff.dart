import 'package:flutter/widgets.dart';

class CodeDiff extends StatelessWidget {
  final String diff;
  final Color deleteColor;
  final Color addColor;
  final Color normalColor;

  const CodeDiff(this.diff, this.deleteColor, this.addColor, this.normalColor,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: diffToText(diff, deleteColor, addColor, normalColor),
    );
  }
}

List<Text> diffToText(
    String diff, Color deleteColor, Color addColor, Color normalColor,
    {double fontSize}) {
  final lines = diff.split("\n");
  return lines.map<Text>((line) {
    final remove = line.indexOf("-") == 0;
    final add = line.indexOf("+") == 0;
    if (remove || add) {
      line = " " + line.substring(1, line.length);
    }
    final style = TextStyle(
        color: remove ? deleteColor : (add ? addColor : normalColor),
        fontSize: fontSize);
    return Text(
      line,
      style: style,
    );
  }).toList();
}
