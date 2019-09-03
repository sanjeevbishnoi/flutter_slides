import 'package:flutter_web/material.dart';

class RegressIcon extends StatelessWidget {
  const RegressIcon({
    Key key,
    this.onClickRegress,
  }) : super(key: key);

  final Function onClickRegress;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return onClickRegress != null
        ? Positioned(
            top: mediaHeight * .94,
            left: mediaWidth * .87,
            child: GestureDetector(
              onTap: () {
                onClickRegress();
              },
              child: Icon(Icons.arrow_back),
            ),
          )
        : Container();
  }
}
