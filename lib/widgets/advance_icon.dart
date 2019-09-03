import 'package:flutter_web/material.dart';

class AdvanceIcon extends StatelessWidget {
  const AdvanceIcon({
    Key key,
    this.onClickAdvance,
  }) : super(key: key);

  final Function onClickAdvance;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return onClickAdvance != null
        ? Positioned(
            top: mediaHeight * .94,
            left: mediaWidth * .9,
            child: GestureDetector(
              onTap: () {
                onClickAdvance();
              },
              child: Icon(Icons.arrow_forward),
            ),
          )
        : Container();
  }
}
