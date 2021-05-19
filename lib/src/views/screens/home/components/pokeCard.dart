import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/views/screens/detalhe/detalhe_screen.dart';
import 'package:pokedex_app/src/views/screens/home/components/typeCard.dart';

import '../../../../core/utils/shared/colors_util.dart';

class PokeCard extends StatefulWidget {

  PokeCard({required this.index, required this.imageUrl});
  final int index; 
  final String imageUrl;

  @override
  _PokeCardState createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      onTap: (){
        navigatorPlus.showModal(
          DetalheScreen(
            ColorsUtil.grass,
            widget.imageUrl
          ),
        );
      },
      radius: RadiusPlus.all(20),
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      padding: const EdgeInsets.all(12),
      color: ColorsUtil.grass,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          this._cardLeft('#001', 'Bulbaa'),
          // Spacer(),
          this._cardRight(),
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

  _cardRight(){
    
    return Row(
      // fit: StackFit.expand,
      children: [
        Hero(
          tag: widget.imageUrl,
          child: Image.network(
            widget.imageUrl,
          ),
        ),
        Align(
          alignment: Alignment.topLeft, 
          child: GestureDetector(
            onTap: (){
              setState(() {
                this.isFavorite = !this.isFavorite;
              });
            },
            child: Icon(
              this.isFavorite ? Icons.favorite_border_outlined : Icons.favorite,
              size: 20,
              color: ColorsUtil.white,
            ),
          )
        )
        
      ],
    );
  }
}