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
    await this._loadFavorites();
    this._loadScrollController();
    this._getPokemons();
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
  
  @observable
  int _page = 0;//Random().nextInt(1110)

  @computed
  bool get hasMoreToLoad{
    return this._page < 1118~/apiOffset && !this.isFiltering && this._pokemonsData.length > 7;
  }

  @action
  _getPokemons() async{

    if(this.isFiltering) return;

    await _pokedexService.getPokemons(this._page * apiOffset, apiOffset).then((response) {
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
    List<PokemonModel> list = [];

    for(var element in _pokemons){
      
      if(this.isSearching || this.isFiltering) break;

      await this._pokedexService.getPokemonByName(element.name).then((response){
        if (response == null || this.isSearching || this.isFiltering)
          return;
        
        list.add(PokemonModel.map(response, _favoritesHavePokemon(element.name!)));
      });
    }

    this._pokemonsData.addAll(list);
    this.loadingPokemons = false;
    this._pokemons.clear();
    print(this._favoritePokemons.length);
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
      this._page = 0;
      this.pokemonsData.clear();
      await this._getPokemons();
      this.isLoading = false;

    }else{//se a lista já tiver items, n precisa buscar mais
      await Future.delayed(Duration(seconds: 1), () => this.isLoading = false);
      
    }
  }

  @action
  _loadScrollController(){
    this.scrollController.addListener(() {
      if(this.scrollController.position.maxScrollExtent == this.scrollController.offset && !this.loadingPokemons){
        // if(this._pokemonsData.length / (apiOffset*(this._page+1)) != 1) return;
        this._page++;
        this.loadingPokemons = true;
        this._getPokemons();
      }
    });
  }
  @observable
  bool loadingPokemons = false;


  //  FAVORITOS

  ObservableList<dynamic> _favoritePokemons = ObservableList();

  @action
  saveFavorites(PokemonModel poke, {bool changeIsFavorite = true})async{//mudar o isFavorite desse pokemon

    if(changeIsFavorite)
      poke.isFavorite = !poke.isFavorite!;

    //se for para favoritar
    if(poke.isFavorite!){
      if(this._favoritesHavePokemon(poke.name!)){
        return;
      }else{
        this._favoritePokemons.add(poke.toMap());
      }
      
    }else {//se for pra tirar da lista de favoritos
      if(this._favoritesHavePokemon(poke.name!))
        this._favoritePokemons.removeWhere((element) => element['name'] == poke.name!);
    }

    if(this.isFiltering && !poke.isFavorite!){
      this._pokemonsData.removeWhere((element) => element.name == poke.name);
    }

    await localStoragePlus.delete(localStoragePath);
    await localStoragePlus.write(localStoragePath, json.encode(this._favoritePokemons));

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

  @action
  _loadFavorites() async{
    final list = await localStoragePlus.read(localStoragePath);
    if(list == null) return;
    this._favoritePokemons.addAll(json.decode(list)); 
  }
}