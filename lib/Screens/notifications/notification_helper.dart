import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationHelpers extends StatelessWidget {
  final int totalNotificatonCount;
  NotificationHelpers({Key? key, required this.totalNotificatonCount})
      : super(key: key);
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Center(
          child: Text(
        "Total notificaton : $totalNotificatonCount",
        style: TextStyle(color: constantColors.darkColor, fontSize: 16),
      )),
    );
  }
}
