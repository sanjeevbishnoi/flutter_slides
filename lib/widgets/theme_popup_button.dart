import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;
//import 'package:tk.slides/models/base_bloc_model.dart';
import 'package:tk.slides/models/ui_state.dart';
import 'package:provider/provider.dart';

class ThemePopupButton extends StatefulWidget {
  @override
  _ThemePopupButtonState createState() => _ThemePopupButtonState();
}

class _ThemePopupButtonState extends State<ThemePopupButton> {
  @override
  Widget build(BuildContext context) {
    /*final BaseBlocModel<UIState> uiStateBloc =
        Provider.of<BaseBlocModel<UIState>>(context);*/
    final UIState uiState = Provider.of<UIState>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: height * .05,
      left: width * .9,
      // Shows how to retrieve a value from the stream
      /*child: StreamBuilder<UIState>(
        stream: Provider.of<BaseBlocModel<UIState>>(context).stream,
        initialData: constants.kInitialColorTheme,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              UIState ui = snapshot.data;
              ui.colorScheme == constants.AppColorScheme.kThemeLight
                  ? uiStateBloc.sink.add(
                      UIState(colorScheme: constants.AppColorScheme.kThemeDark))
                  : uiStateBloc.sink.add(UIState(
                      colorScheme: constants.AppColorScheme.kThemeLight));
              ;
            },*/
      child: Container(
        child: PopupMenuButton<constants.AppColorScheme>(
          onSelected: (constants.AppColorScheme result) {
            if (result == constants.AppColorScheme.kThemeLight) {
              //uiStateBloc.sink.add(
              //    UIState(colorScheme: constants.AppColorScheme.kThemeLight));
              uiState.colorScheme = constants.AppColorScheme.kThemeLight;
            } else {
              //uiStateBloc.sink.add(
              //    UIState(colorScheme: constants.AppColorScheme.kThemeDark));
              uiState.colorScheme = constants.AppColorScheme.kThemeDark;
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<constants.AppColorScheme>>[
            const PopupMenuItem<constants.AppColorScheme>(
              value: constants.AppColorScheme.kThemeDark,
              child: Text(
                'Dark',
                style: TextStyle(fontFamily: constants.kFontFamily),
              ),
            ),
            const PopupMenuItem<constants.AppColorScheme>(
              value: constants.AppColorScheme.kThemeLight,
              child: Text(
                'Light',
                style: TextStyle(fontFamily: constants.kFontFamily),
              ),
            ),
          ],
        ),
      ),
    );
    //},
    //),
    //);
  }
}
