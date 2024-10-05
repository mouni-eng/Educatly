import 'package:flutter/material.dart';

navigateTo({
  required Widget view,
  required BuildContext context,
  bool withNavBar = false,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => view),
  );
}

navigateReplacment({required Widget view, required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => view), (route) => true);
}
