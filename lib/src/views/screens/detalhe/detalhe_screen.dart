import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/core/models/pokemon_model.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';
import 'package:pokedex_app/src/views/screens/home/components/typeCard.dart';

import 'components/animated_hero.dart';

class DetalheScreen extends StatefulWidget {

  DetalheScreen(this.pokemon, this.setIsFavorite);

  final PokemonModel pokemon;
  final Function setIsFavorite;

  @override
  _DetalheScreenState createState() => _DetalheScreenState();
}

class _DetalheScreenState extends State<DetalheScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(context),
    );
  }

  _buildAppBar(){
    return AppBar(
      backgroundColor: this.widget.pokemon.color!,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            this.widget.pokemon.isFavorite! ? Icons.favorite : Icons.favorite_border_outlined
          ),
          onPressed: (){
            setState(() {});
            this.widget.setIsFavorite();
          },
        )
      ],
    );
  }

  _buildBody(BuildContext context){
    return ContainerPlus(
      color: this.widget.pokemon.color!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContainerPlus(
              isCenter: true,
              margin: EdgeInsets.symmetric(horizontal:48),
              child: AnimatedHero(
                child: Hero(
                  tag: this.widget.pokemon.id!,
                  child: Image.network(
                    this.widget.pokemon.imgUrl!,
                  ),
                ),
              )
            ),
            TextPlus(
              this.widget.pokemon.name!.capitalizeFirstWord,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: ColorsUtil.white,
              margin: const EdgeInsets.symmetric(vertical:12),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: this.widget.pokemon.types!.map((type){
                return TypeCard(type, cardFont: 16, );
              }).toList()
            ),

            this._statusBarContainer(MediaQuery.of(context).size.width),
          ],
        ),
        
      ),
    );
  }

  _statusBarContainer(double size){

    return ContainerPlus(
      radius: RadiusPlus.top(20),
      color: ColorsUtil.white,
      width: size,
      height: 300,
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics() ,
        child: Column(
          children: [
            TextPlus(
              'Status',
              color: ColorsUtil.status,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              margin: EdgeInsets.only(top:16),
              textDecorationPlus: TextDecorationPlus(
                // decorationThickness: 2,
                textDecoration: TextDecoration.underline,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 24),
              child: Column(
                children: [
                  this._statusData('HP'),
                  this._statusData('Attack'),
                  this._statusData('Defense'),
                  this._statusData('Special-Attack'),
                  this._statusData('Special-Defense'),
                  this._statusData('Speed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _statusData(String statusLabel){
    
    return ContainerPlus(
      margin: EdgeInsets.only(bottom:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPlus(
            statusLabel,
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: ColorsUtil.status,
          ),
          Spacer(),
          TextPlus(
            this.widget.pokemon.stats![statusLabel].toString(),
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: ColorsUtil.status,
            margin: EdgeInsets.only(right: 16),
          ),
          ContainerPlus(
            width: 130,
            height: 10,
            radius: RadiusPlus.all(10),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: this.widget.pokemon.stats![statusLabel]/200,), 
              duration: Duration(milliseconds: 1800), 
              builder: (context, double value, _){ 
                return LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorsUtil.colorByStats[statusLabel] ?? ColorsUtil.colorless),
                  backgroundColor: ColorsUtil.colorByStats[statusLabel]?.withOpacity(0.2) ?? ColorsUtil.colorless.withOpacity(0.2),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
