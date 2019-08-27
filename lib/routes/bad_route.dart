import 'package:flutter_web/material.dart';
import 'package:tk.slides/routes/title_slide.dart';

class BadRoute extends StatelessWidget {
  final String routeName;

  BadRoute({this.routeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(TitleSlide.routeName));
          },
        ),
        Center(
          child: Text('404 Not Found - ${routeName}'),
        ),
      ],
    );
  }
}
