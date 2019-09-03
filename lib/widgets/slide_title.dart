import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;

class SlideTitle extends StatelessWidget {
  const SlideTitle({
    Key key,
    @required this.titleText,
    //@required this.backButtonCallback,
  }) : super(key: key);

  final titleText; //, backButtonCallback;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: mediaWidth * .1,
      top: mediaHeight * .04,
      child: Hero(
        tag: constants.kTitleSlideHeroKey,
        child: Container(
          width: mediaWidth * .8,
          height: mediaHeight * .1,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    titleText,
                    style: constants.kMediumTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
