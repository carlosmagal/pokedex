import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex_app/src/core/models/pokemon_model.dart';
import 'package:pokedex_app/src/core/models/pokemon_dto.dart';
import 'package:pokedex_app/src/core/services/pokedex_service.dart';
import 'package:pokedex_app/src/core/utils/shared/constants.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final _pokedexService = PokedexService();

  _HomeController() {
    this._loadHomeController();
  }

  _loadHomeController() async{
    await this._loadFavoritesList();
    this._getPokemons();
  }

  @observable
  ObservableMap <String, dynamic> _favoritesMap = ObservableMap();

  ObservableList<PokemonModel> _pokemonsFilteredByFavorite = ObservableList();

  @computed
  List<PokemonModel> get pokemonsFiltered{
    return this._pokemonsFilteredByFavorite;
  }

  @observable 
  ScrollController scrollController = ScrollController();

  @observable
  TextEditingController textController = TextEditingController();

  @observable
  List<PokemonDTO> _pokemons = [];

  @computed
  List<PokemonDTO> get pokemons {
    return _pokemons;
  }

  @action
  _getPokemons() async{
    await _pokedexService.getPokemons(Random().nextInt(1110), 15).then((response) {
      if (response == null && response['results'] != null) {
        _pokemons = [];
      }
      var list = response['results'] as List;
      _pokemons = list.map((jsonIten) => PokemonDTO.map(jsonIten)).toList();

      _getPokemonCardData();

    }).catchError((error) {
      this._setErrorMessage('Erro ao listar Pokemons!');

    });
  }

  @observable 
  ObservableList<PokemonModel> _pokemonsData = ObservableList();

  @computed
  List<PokemonModel> get pokemonsData{
    return this._pokemonsData;
  }

  @action 
  _getPokemonCardData() async{
    for(var element in _pokemons){
      
      if(this.isSearching) break;

      await this._pokedexService.getPokemonByName(element.name).then((response){
        if (response == null ) {
          return;
        }
        //se ja tiver no salvo no map, manda o valor que estiver la
        if(this._favoritesMap.containsKey(element.name!)){
          this._pokemonsData.add(PokemonModel.map(response, this._favoritesMap[element.name!]));

        }else {//se nao estiver salvo, vai como false e é cadastrado no map
          this._pokemonsData.add(PokemonModel.map(response, false));
          this.setFavorites(element.name!, false);

        }
      });
    }
    print(this._favoritesMap);
  }

  @observable
  bool isSearching = false;

  @observable
  bool isFiltering = false;

  @observable
  bool isLoading = false;

  @observable 
  bool error = false;

  @observable
  String errorMessage = '';

  @observable
  String _searchText = '';

  @computed
  bool get showSuffix {
    return this._searchText.isNotEmpty;
  }

  @action
  setSearchText(String text){
    this._searchText = text;
  }

  @action
  _setErrorMessage(String errorText){
    this.error = true;
    this.errorMessage = errorText;
  }

  @action
  searchPokemon() async{

    if(this._searchText.isEmpty) return;
    
    this.isSearching = true;
    this.error = false;
    this.isFiltering = false;

    await this._pokedexService.getPokemonByName(this._searchText.toLowerCase()).then((response){
      if(response == null){
        this._setErrorMessage('Pokemon não encontrado!');
        return;
      }
      
      this._pokemonsData.clear();
      
      //se ja tiver no salvo no favoritesmap, manda o valor que estiver la
      if(this._favoritesMap.containsKey(this._searchText.toLowerCase()))    
        this._pokemonsData.add(PokemonModel.map(response, this._favoritesMap[this._searchText.toLowerCase()]));
      else        
        this._pokemonsData.add(PokemonModel.map(response, false));

    }).catchError((error){
      this._setErrorMessage('Pokemon não encontrado!');

    });

    this.isSearching = false;
  }

  @computed
  bool get disableButtons{
    return this.isLoading || this.isSearching;
  }

  @action
  refreshPokemonsList({bool refreshAll = false})async{
    
    this.error = false;
    this.textController.clear();
    this._searchText = '';
    this.isLoading = true;

    //se a lista de pokemons estiver vazia, é preenchida novamente
    if(this.pokemonsData.isEmpty || this.pokemonsData.length == 1 || refreshAll){
      this.pokemonsData.clear();
      await this._getPokemons();
      this.isLoading = false;

    }else{//se a lista já tiver items, n precisa buscar mais
      await Future.delayed(Duration(seconds: 1), () => this.isLoading = false);
      
    }
  }

  @action
  _loadFavoritesList() async{
    final list = await localStoragePlus.read(localStoragePath);
    if(list == null) return;
    this._favoritesMap.addAll(json.decode(list));
  }

  @action
  setFavorites(String key, bool value) async{

    PokemonModel? itemToBeRemoved;

    if(this._favoritesMap.containsKey(key)){
      this._favoritesMap[key] = value;

    } else {
      this._favoritesMap.addAll({
        key: value
      });

    }
    
    this._pokemonsData.forEach((element) {//mudando o isFavorite do pokemon
      if(element.name == key)
        element.isFavorite = value;
    });

    //caso o elemento esteja na lista de favoritos e nao esteja mais como favorito
    this._pokemonsFilteredByFavorite.forEach((element) {
      if(element.name == key){
        if(!value){
          itemToBeRemoved = element;
          return;
        }
      }
    });

    if(itemToBeRemoved != null)
      this._pokemonsFilteredByFavorite.removeWhere((r) => r == itemToBeRemoved);

    await localStoragePlus.delete(localStoragePath);
    await localStoragePlus.write(localStoragePath, json.encode(this._favoritesMap));
  }

  @action
  _setFilteredPokemons(String key)async{
    
    await this._pokedexService.getPokemonByName(key).then((response){
      if (response == null ) {
        return;
      }

      this._pokemonsFilteredByFavorite.add(PokemonModel.map(response, true));
    }).catchError((error){
      this._setErrorMessage('Erro ao listar Pokemons!');
    });
  }

  @action
  filterPokemons()async{
    if(this.isFiltering){
      this.isFiltering = false;
      return;

    }
    this.isLoading = true;
    this.error = false;
    this.textController.clear();
    this._searchText = '';
    this.isFiltering = true;
    
    this._favoritesMap.forEach((key, value) async{
      if(this.isSearching) return;

      if(value){
        if(this._containsPokemon(key)){//lista de favoritos já tem o pokemon
          return;
        }
        await this._setFilteredPokemons(key);
        
      }
    });

    await Future.delayed(Duration(milliseconds: 1200), () => this.isLoading = false);
  }
  
  _containsPokemon(String name){
    return this._pokemonsFilteredByFavorite.where((element) => element.name == name).isNotEmpty;

  }

}

    // this.scrollController.addListener(() {
    //   if(this.scrollController.position.atEdge){
    //     if (this.scrollController.position.pixels == 0) {
    //       print('top'); 
    //     } else {
    //       print('bottom');
    //     }
    //   }
    // });