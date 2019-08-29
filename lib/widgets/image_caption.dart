import 'package:flutter_web/material.dart';
import 'dart:html' as html;

class ImageCaption extends StatelessWidget {
  const ImageCaption({
    Key key,
    @required this.link,
    @required this.caption,
  }) : super(key: key);

  final String link;
  final String caption;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return Positioned(
      top: mediaHeight * .95,
      left: mediaWidth * .1,
      child: Container(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (link != null) {
                  html.window.open(link, 'Unsplash');
                }
              },
              child: Text(caption),
            ),
          ],
        ),
      ),
    );
  }
}
