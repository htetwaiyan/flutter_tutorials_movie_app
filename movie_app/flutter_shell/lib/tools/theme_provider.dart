import 'package:flutter/material.dart';
import 'package:flutter_shell/tools/theme_bloc.dart';


class ThemeProvider extends InheritedWidget {

  final ThemeBloc nightMode;

  const ThemeProvider({Key key,@required Widget child,this.nightMode})
      : assert(child != null),
        super(key: key, child: child);

  static ThemeProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ThemeProvider) as ThemeProvider;
  }

  @override
  bool updateShouldNotify(ThemeProvider old) {
    return true;
  }
}