import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';

import '../../../core/utils/shared/colors_util.dart';
import 'components/pokeCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: this._buildAppBar(),
      body: this._buildBody(),
    );
  }

  _buildAppBar(){

    return AppBar(
      backgroundColor: ColorsUtil.headerBackground,
      elevation: 0,
      title: TextPlus(
        'Pokédex',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorsUtil.cinzaEscuro,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(
            Icons.favorite_border_rounded,
            color: ColorsUtil.cinzaEscuro,
          ),
        ),
      ],
    );
  }

  _buildBody(){
    return Column(
      children: [
        this._headerTextField(),
        Expanded(
          child: ListView.builder(
            // padding: EdgeInsets.symmetric(vertical: 16, ),
            physics: BouncingScrollPhysics(),
            itemCount: 31,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index){
              return PokeCard(
                index: index,
                imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(index+1).toString()}.png',
              );
            }
          ),
        ),
      ],
    );
  }

  _headerTextField(){
    return ContainerPlus(
      radius: RadiusPlus.bottom(20),
      color: ColorsUtil.headerBackground,
      shadows: [
        ShadowPlus(
          color: ColorsUtil.black,
          moveDown: 4,
          blur: 2,
          spread: 0,
          opacity: 0.1,
        ),
      ],
      child: TextFieldPlus(
        margin: EdgeInsets.fromLTRB( 16, 0, 16, 24),
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: 48,
        backgroundColor: ColorsUtil.textField,
        cursorColor: ColorsUtil.cinzaEscuro,
        enabled: true,
        radius: RadiusPlus.all(12),
        // textInputType: TextInputType.,
        textInputAction: TextInputAction.search,
        onSubmitted: (d){
          print(d);
        },
        placeholder: TextPlus(
          'Search Pokemon',
          color: ColorsUtil.textFieldIcon,
        ),
        prefixWidget: Icon(
          Icons.search,
          color: ColorsUtil.textFieldIcon,
          size: 24,
        ),
      ),
    );
  }
}