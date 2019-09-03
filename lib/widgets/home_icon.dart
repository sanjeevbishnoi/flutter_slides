import 'package:flutter_web/material.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: height * .063,
      left: width * .88,
      child: Container(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}
