import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

import '../../../../core/utils/shared/colors_util.dart';

class TypeCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      isCircle: true,
      height: 20,
      border: BorderPlus(
        width: 0.5,
        color: Colors.white
      ),
      color: Color.fromRGBO(255, 255, 255, .3),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right:4),
      child: TextPlus(
        'poison'.capitalizeFirstWord,
        color: ColorsUtil.white,
        fontWeight: FontWeight.w700,
        isCenter: true,
        fontSize: 10,
      ),
    );
  }
}