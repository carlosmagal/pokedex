import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';
import 'package:pokedex_app/src/core/utils/shared/constants.dart';
import 'package:pokedex_app/src/views/screens/home/home_controller.dart';

import '../../../core/utils/shared/colors_util.dart';
import 'components/pokeCard.dart';

class HomeScreen extends StatelessWidget {

  final _homeController = GetIt.I<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return this._onPop();
      },
      child: Scaffold(
        backgroundColor: ColorsUtil.background,
        appBar: this._buildAppBar(),
        body: this._buildBody(),
      ),
    );
  }

  bool _onPop(){
    dialogPlus.showDefault(
      title: 'Deseja sair do aplicativo?',
      elementsSpacing: 32,
      elevation: 100,
      buttonsHeight: 40,
      radius: RadiusPlus.all(8),
      buttonOneText: 'Cancelar',
      buttonTwoText: 'Confirmar',
      buttonOneCallback: () {
        navigatorPlus.back();
      },
      buttonTwoCallback: () {
        SystemNavigator.pop();
      },
      buttonOneColor: Colors.red,
      titleWeight: FontWeight.w500,
    );
    return false;
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
        Observer(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: this._homeController.disableButtons ? null : 
                (){
                  this._homeController.changeToFiltered();
                },
                child: Icon(
                  this._homeController.isFiltering ? Icons.favorite : Icons.favorite_border_outlined,
                  color: this._homeController.disableButtons ?
                    ColorsUtil.cinzaEscuro.withOpacity(0.5) : ColorsUtil.cinzaEscuro,
                ),
              ),
            );
          }
        ),
      ],
    );
  }

  _buildBody(){
    return Column(
      children: [
        this._headerTextField(),
        Expanded(
          child: Observer(
            builder: (context) {
              if(this._homeController.error)
                return this._bodyError();
              
              if(this._homeController.isFiltering && this._homeController.pokemonsData.isEmpty)
                return this._bodyEmptyList();
              
              if(this._homeController.pokemonsData.isEmpty || this._homeController.isSearching || this._homeController.isLoading)
                return this._bodyProgress();

              return this._bodyPokemonList();
            }
          ),
        ),
      ],
    );
  }

  _headerTextField(){
    return Observer(
      builder: (context) {
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
            controller: this._homeController.textController,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
            padding: EdgeInsets.fromLTRB(18, 0, 8, 0),
            height: 48,
            backgroundColor: ColorsUtil.textField,
            cursorColor: ColorsUtil.cinzaEscuro,
            enabled: !this._homeController.isSearching && !this._homeController.isLoading,
            radius: RadiusPlus.all(12),
            maxLength: 30,
            textInputAction: TextInputAction.search,
            onChanged: this._homeController.setSearchText,
            onSubmitted: (text){
              this._homeController.searchPokemon();
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
            suffixWidget: this._homeController.showSuffix ? IconButton(
              icon: Icon(
                Icons.close_rounded,
                color: ColorsUtil.textFieldIcon,
              ), 
              onPressed: (){
                // utilsPlus.closeKeyboard();
                this._homeController.textController.clear();
                this._homeController.setSearchText('');
              }
            ) : null,
          ),
        );
      }
    );
  }

  _bodyError(){
    return GestureDetector(
      onTap: (){
        this._homeController.refreshPokemonsList(refreshAll: true);
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outlined,
              color: ColorsUtil.cinzaEscuro,
              size: 60,
            ),
            TextPlus(
              this._homeController.errorMessage,
              color: ColorsUtil.cinzaEscuro,
              fontSize: 24,
            ),
            TextPlus(
              'Toque para recarregar',
              margin: EdgeInsets.only(top: 8),
              color: ColorsUtil.cinzaEscuro,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  _bodyProgress(){
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ColorsUtil.cinzaEscuro),
      )
    );
  }

  _bodyPokemonList(){
    return Observer(
      builder: (context){
        return ListView.builder(
          controller: this._homeController.scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 16.0),
          itemCount: this._homeController.pokemonsData.length + 1,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index){
            if(index < this._homeController.pokemonsData.length)
              return PokeCard(
                this._homeController.pokemonsData[index],
                this._homeController.saveFavorites,
                this._homeController.isFiltering,
              );

            if(this._homeController.hasMoreToLoad)
              return this._loadingContainer();

            return Container();
          }
        );
      }
    );
  }

  _bodyEmptyList(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            pokeballPath,
            width: 140,
          ),
          TextPlus(
            'Sua lista de favoritos está vazia!',
            color: ColorsUtil.cinzaEscuro,
            fontSize: 24,
            margin: EdgeInsets.only(top: 8),
          ),
          TextPlus(
            'Toque nos corações para adicionar os pokemons à sua lista.',
            margin: EdgeInsets.only(top: 8),
            color: ColorsUtil.pokeballRed,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  _loadingContainer(){
    return ContainerPlus(
      radius: RadiusPlus.all(20),
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      height: 85,
      skeleton: SkeletonPlus.custom(
        enabled: true,
      ),
    );
  }
}