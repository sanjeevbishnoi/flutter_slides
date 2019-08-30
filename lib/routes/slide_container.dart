import 'package:flutter_web/material.dart';
import 'package:tk.slides/routes/animated_slide.dart';
import 'package:tk.slides/routes/text_slide.dart';
import 'package:tk.slides/routes/image_slide.dart';

class SlideContainer extends StatefulWidget {
  static const String routeName = 'slide';

  @override
  _TitleRouteState createState() => _TitleRouteState();
}

class _TitleRouteState extends State<SlideContainer> {
  PageController pageController = PageController();
  double currentPageValue = 0.0;

  @override
  initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void advancePageView() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          AnimatedSlide(onClickAdvance: advancePageView),
          /*PageView(
            scrollDirection: Axis.vertical,
            children: <Widget>[*/
          TextSlide(onClickAdvance: advancePageView),
          ImageSlide(onClickAdvance: advancePageView),
          //],
          // )
        ],
      ),
    );
  }
}
