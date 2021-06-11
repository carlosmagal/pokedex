import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/core/models/pokemon_model.dart';
import 'package:pokedex_app/src/views/screens/detalhe/detalhe_screen.dart';
import 'package:pokedex_app/src/views/screens/home/components/typeCard.dart';

import '../../../../core/utils/shared/colors_util.dart';

class PokeCard extends StatefulWidget {

  PokeCard(this.pokemon, this.setIsFavorite, this.isFiltering);

  final PokemonModel pokemon;
  final Function setIsFavorite;
  final bool isFiltering;

  @override
  _PokeCardState createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      onTap: ()async{
        await navigatorPlus.showModal(
          DetalheScreen(
            widget.pokemon,
            this._setFavorite,
            widget.isFiltering
          ),
        );

        //caso esteja filtrando e o favorito do pokemon seja false, ele tira da lista
        if(widget.isFiltering && !widget.pokemon.isFavorite!)
          await widget.setIsFavorite(widget.pokemon, changeIsFavorite: false);
      },
      radius: RadiusPlus.all(20),
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      padding: const EdgeInsets.all(12),
      color: widget.pokemon.color!,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          this._cardLeft('#0${(widget.pokemon.id!).toString()}', widget.pokemon.name!),
          // Spacer(),
          this._cardRight(widget.pokemon.imgUrl!, widget.pokemon.id!),
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
              id,
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: ColorsUtil.white,
              textAlign: TextAlign.start,
            ),
            TextPlus(
              name.capitalizeFirstWord,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorsUtil.white,
            ),
          ],
        ),
        Row(
          children: widget.pokemon.types!.map((type){
            return TypeCard(type);
          }).toList(),
        )
      ],
    );
  }

  _cardRight(String image, int id){
    
    return Row(
      // fit: StackFit.expand,
      children: [
        Hero(
          tag: id,
          child: Image.network(
            image,
          ),
        ),
        Align(
          alignment: Alignment.topLeft, 
          child: GestureDetector(
            onTap: this._setFavorite,
            child: Icon(
              widget.pokemon.isFavorite! ? Icons.favorite : Icons.favorite_border_outlined,
              size: 20,
              color: ColorsUtil.white,
            ),
          )
        )
      ],
    );
  }

  _setFavorite() async{
    setState(() {});
     
    await widget.setIsFavorite(widget.pokemon);
  }
  
}