import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;

class SlideTitle extends StatelessWidget {
  const SlideTitle({
    Key key,
    @required titleText,
  })  : this.titleText = titleText,
        super(key: key);

  final titleText;

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
          height: 100,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
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
    );
  }
}
