import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/views/screens/home/components/typeCard.dart';

import '../../../../core/utils/shared/colors_util.dart';

class PokeCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        radius: RadiusPlus.all(20),
        margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        padding: const EdgeInsets.all(12),
        color: utilsPlus.colorHex('#48D0B0'),
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            this._cardLeft('#001', 'Bulbaa'),
            Spacer(),
            this._cardRight(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png', 
            ),
          ],
        ),
      
    );
  }


  _cardLeft(String id, String name){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPlus(
              '#001',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: ColorsUtil.white,
              textAlign: TextAlign.start,
            ),
            TextPlus(
              'Bulbasaur',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorsUtil.white,
            ),
          ],
        ),
        Row(
          children: [
            TypeCard(),
            TypeCard(),
          ],
        )
      ],
    );
  }

  _cardRight(String url){
    
    return Row(
      // fit: StackFit.expand,
      children: [
        Image.network(
           url,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            child: Icon(
              Icons.favorite_border_outlined,
              size: 20,
              color: ColorsUtil.white,
            ),
          )
        )
        
      ],
    );
  }
}



