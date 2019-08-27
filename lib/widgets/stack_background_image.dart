import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart';
import 'package:tk.slides/models/ui_state.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class StackBackgroundImage extends StatelessWidget {
  const StackBackgroundImage({
    Key key,
    this.opacity = 1,
    @required this.image,
    this.scale = 1,
    this.caption = '',
    this.link = '',
  }) : super(key: key);

  final double opacity;
  final String image, caption, link;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    final UIState uiState = Provider.of<UIState>(context);

    return Transform.scale(
      scale: scale,
      child: Stack(
        children: <Widget>[
          Container(
            width: mediaWidth,
            height: mediaHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          //),
          // Gradient overlay
          /*Container(
            width: mediaWidth,
            // allow the height of the gradient to extend slightly beyond the image
            // prevents the image from peeking out
            height: mediaHeight + 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  //Colors.transparent,
                  Colors.white,
                  Colors.transparent,
                  //Theme.of(context).hintColor,
                  Colors.white,
                ],
                stops: [0, .3, 1],
                tileMode: TileMode.clamp,
              ),
            ),
          ),*/
          Container(
            width: mediaWidth,
            height: mediaHeight,
            color: uiState.colorScheme == AppColorScheme.kThemeDark
                ? Color.fromRGBO(0, 0, 0, opacity)
                : Color.fromRGBO(255, 255, 255, opacity),
          ),
          Positioned(
            top: mediaHeight * .95,
            left: mediaWidth * .1,
            child: Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (link != null) {
                        //html.window.location.href = link;
                        html.window.open(link, 'Unsplash');
                      }
                    },
                    child: Text(caption),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
