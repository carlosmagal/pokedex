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

  @observable
  ObservableList<PokemonModel> _pokemonsFilteredByFavorite = ObservableList();

  @computed
  List<PokemonModel> get pokemonsFiltered{
    return this._pokemonsFilteredByFavorite.where((element) => element.isFavorite!).toList();
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
      
      if(this.isSearching || this.isFiltering) break;

      await this._pokedexService.getPokemonByName(element.name).then((response){
        if (response == null || this.isSearching || this.isFiltering) {
          return;
        }
        //se ja tiver no salvo no map, manda o valor que estiver la
        // if(this._favoritesMap.containsKey(element.name!)){
        //   this._pokemonsData.add(PokemonModel.map(response, this._favoritesMap[element.name!]));

        // }else {//se nao estiver salvo, vai como false e é cadastrado no map
        //   this._pokemonsData.add(PokemonModel.map(response, false));
        //   this.setFavorites(element.name!, false);
        // }
      this._pokemonsData.add(PokemonModel.map(response, _favoritesHavePokemon(element.name!)));

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
      final name = response['name'];//caso a pesquisa seja feita pelo número(id)
      
      //se ja tiver no salvo no favoritesmap, manda o valor que estiver la
      // if(this._favoritesMap.containsKey(name))    
      //   this._pokemonsData.add(PokemonModel.map(response, this._favoritesMap[name]));
      // else        
      //   this._pokemonsData.add(PokemonModel.map(response, false));

      this._pokemonsData.add(PokemonModel.map(response, _favoritesHavePokemon(name)));

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
    
    this._pokemonsFilteredByFavorite.forEach((element) {
      if(element.name == key)
        element.isFavorite = value;
    });

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
      this._pokemonsFilteredByFavorite.removeWhere((element) => !element.isFavorite!);
      this.isFiltering = false;
      await this.refreshPokemonsList();
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

  //  NEW FAVORITES------------





  ObservableList<Map<String, dynamic>> _favoritePokemons = ObservableList();

  @action
  saveFavorites(PokemonModel poke){//mudar o isFavorite desse pokemon

    poke.isFavorite = !poke.isFavorite!;

    //se for para favoritar
    if(poke.isFavorite!){

      if(this._favoritesHavePokemon(poke.name!)){
        return;
      }else{
        this._favoritePokemons.add(poke.toMap());
      }
      
    }else if(!poke.isFavorite!){//se for pra tirar da lista de favoritos
      if(this._favoritesHavePokemon(poke.name!))
        this._favoritePokemons.removeWhere((element) => element['name'] == poke.name!);
    }

    if(this.isFiltering && !poke.isFavorite!){
      this._pokemonsData.removeWhere((element) => element.name == poke.name);
    }

    print(this._favoritePokemons.length);
  }

  _favoritesHavePokemon(String name){
    return this._favoritePokemons.where((element) => element['name'] == name).isNotEmpty;
  }

  @action
  changeToFiltered()async {

    if(this.isFiltering){
      this.isFiltering = false;
      await this.refreshPokemonsList(refreshAll: true);
      return;
    }

    this.isLoading = true;
    this.error = false;
    this.textController.clear();
    this._searchText = '';
    this.isFiltering = true;

    this._pokemonsData.clear();

    this._favoritePokemons.forEach((element) {
      if(element['isFavorite'])
        this._pokemonsData.add(PokemonModel.fromFavoritesMap(element));
    });
    
    this._pokemonsData.sort((p1,p2)=>p1.id!.compareTo(p2.id!));

    await Future.delayed(Duration(milliseconds: 1200), () => this.isLoading = false);


  }

  // @action
  // _loadFavorites() async{
  //   final list = await localStoragePlus.read('newfavs');
  //   if(list == null) return;
  //   this._favoritesMap.addAll(json.decode(list)); 
  // }
}