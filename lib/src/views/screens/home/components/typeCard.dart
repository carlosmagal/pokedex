import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

import '../../../../core/utils/shared/colors_util.dart';

class TypeCard extends StatelessWidget {
  
  TypeCard({this.cardFont = 10, this.cardMargin = 4});

  final double cardFont;
  final double cardMargin;

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      isCircle: true,
      border: BorderPlus(
        width: 0.5,
        color: ColorsUtil.white
      ),
      color: ColorsUtil.typeCard,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right: this.cardMargin),
      child: TextPlus(
        'poison'.capitalizeFirstWord,
        color: ColorsUtil.white,
        fontWeight: FontWeight.w700,
        isCenter: true,
        fontSize: this.cardFont,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      ),
    );
  }
}