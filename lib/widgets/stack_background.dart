import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart';
import 'package:tk.slides/models/ui_state.dart';
import 'package:provider/provider.dart';
import 'package:tk.slides/widgets/image_caption.dart';

class StackBackground extends StatelessWidget {
  const StackBackground({
    Key key,
    this.opacity = 1,
    this.image,
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
              image: image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    )
                  : null,
            ),
          ),
          Container(
            width: mediaWidth,
            height: mediaHeight,
            color: uiState.colorScheme == AppColorScheme.kThemeDark
                ? Color.fromRGBO(0, 0, 0, opacity)
                : Color.fromRGBO(255, 255, 255, opacity),
          ),
          ImageCaption(link: link, caption: caption),
        ],
      ),
    );
  }
}
