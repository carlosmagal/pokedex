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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }


  _buildAppBar(){

    return PreferredSize(
      preferredSize: Size.fromHeight(150.0),
      child: ContainerPlus(
        color: ColorsUtil.headerBackground,
        child: Column(
          children: [
            _headerTitle(),
            _headerTextField()
          ],
        ),
      ), 
    );
  }

  _headerTitle(){

    return ContainerPlus(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPlus(
            'Pokédex',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: ColorsUtil.cinzaEscuro,
          ),
          Icon(
            Icons.favorite_border_rounded
          ),
        ],
      ),
    );
  }

  _headerTextField(){
    return ContainerPlus(
      radius: RadiusPlus.bottom(20),
      color: ColorsUtil.headerBackground,
      shadows: [
        ShadowPlus(
          color: Colors.black,
          moveDown: 1,
          blur: 2,
          spread: 1,
          opacity: 0.1,
        ),
      ],
      child: TextFieldPlus(
        margin: EdgeInsets.fromLTRB( 16, 0, 16, 24),
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: 48,
        backgroundColor: ColorsUtil.textField,
        cursorColor: Colors.black,
        enabled: true,
        radius: RadiusPlus.all(12),
        // textInputType: TextInputType.,
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

  _buildBody(){
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index){
        return PokeCard();
      }
    );
  }

}