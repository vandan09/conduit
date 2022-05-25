import 'package:first_app/provider/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        activeColor: Colors.black,
        value: themeprovider.isDarkMode,
        onChanged: (value) {
          setState(() {
            themeprovider = Provider.of<ThemeProvider>(context, listen: false);
            themeprovider.toggleTheme(value);
          });
        });
  }
}
