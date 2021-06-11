// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  Computed<List<PokemonModel>>? _$pokemonsFilteredComputed;

  @override
  List<PokemonModel> get pokemonsFiltered => (_$pokemonsFilteredComputed ??=
          Computed<List<PokemonModel>>(() => super.pokemonsFiltered,
              name: '_HomeController.pokemonsFiltered'))
      .value;
  Computed<List<PokemonDTO>>? _$pokemonsComputed;

  @override
  List<PokemonDTO> get pokemons =>
      (_$pokemonsComputed ??= Computed<List<PokemonDTO>>(() => super.pokemons,
              name: '_HomeController.pokemons'))
          .value;
  Computed<List<PokemonModel>>? _$pokemonsDataComputed;

  @override
  List<PokemonModel> get pokemonsData => (_$pokemonsDataComputed ??=
          Computed<List<PokemonModel>>(() => super.pokemonsData,
              name: '_HomeController.pokemonsData'))
      .value;
  Computed<bool>? _$showSuffixComputed;

  @override
  bool get showSuffix =>
      (_$showSuffixComputed ??= Computed<bool>(() => super.showSuffix,
              name: '_HomeController.showSuffix'))
          .value;
  Computed<bool>? _$disableButtonsComputed;

  @override
  bool get disableButtons =>
      (_$disableButtonsComputed ??= Computed<bool>(() => super.disableButtons,
              name: '_HomeController.disableButtons'))
          .value;

  final _$_favoritesMapAtom = Atom(name: '_HomeController._favoritesMap');

  @override
  ObservableMap<String, dynamic> get _favoritesMap {
    _$_favoritesMapAtom.reportRead();
    return super._favoritesMap;
  }

  @override
  set _favoritesMap(ObservableMap<String, dynamic> value) {
    _$_favoritesMapAtom.reportWrite(value, super._favoritesMap, () {
      super._favoritesMap = value;
    });
  }

  final _$_pokemonsFilteredByFavoriteAtom =
      Atom(name: '_HomeController._pokemonsFilteredByFavorite');

  @override
  ObservableList<PokemonModel> get _pokemonsFilteredByFavorite {
    _$_pokemonsFilteredByFavoriteAtom.reportRead();
    return super._pokemonsFilteredByFavorite;
  }

  @override
  set _pokemonsFilteredByFavorite(ObservableList<PokemonModel> value) {
    _$_pokemonsFilteredByFavoriteAtom
        .reportWrite(value, super._pokemonsFilteredByFavorite, () {
      super._pokemonsFilteredByFavorite = value;
    });
  }

  final _$scrollControllerAtom = Atom(name: '_HomeController.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$textControllerAtom = Atom(name: '_HomeController.textController');

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  final _$_pokemonsAtom = Atom(name: '_HomeController._pokemons');

  @override
  List<PokemonDTO> get _pokemons {
    _$_pokemonsAtom.reportRead();
    return super._pokemons;
  }

  @override
  set _pokemons(List<PokemonDTO> value) {
    _$_pokemonsAtom.reportWrite(value, super._pokemons, () {
      super._pokemons = value;
    });
  }

  final _$_pokemonsDataAtom = Atom(name: '_HomeController._pokemonsData');

  @override
  ObservableList<PokemonModel> get _pokemonsData {
    _$_pokemonsDataAtom.reportRead();
    return super._pokemonsData;
  }

  @override
  set _pokemonsData(ObservableList<PokemonModel> value) {
    _$_pokemonsDataAtom.reportWrite(value, super._pokemonsData, () {
      super._pokemonsData = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_HomeController.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$isFilteringAtom = Atom(name: '_HomeController.isFiltering');

  @override
  bool get isFiltering {
    _$isFilteringAtom.reportRead();
    return super.isFiltering;
  }

  @override
  set isFiltering(bool value) {
    _$isFilteringAtom.reportWrite(value, super.isFiltering, () {
      super.isFiltering = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomeController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_HomeController.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_HomeController.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_searchTextAtom = Atom(name: '_HomeController._searchText');

  @override
  String get _searchText {
    _$_searchTextAtom.reportRead();
    return super._searchText;
  }

  @override
  set _searchText(String value) {
    _$_searchTextAtom.reportWrite(value, super._searchText, () {
      super._searchText = value;
    });
  }

  final _$_getPokemonsAsyncAction = AsyncAction('_HomeController._getPokemons');

  @override
  Future _getPokemons() {
    return _$_getPokemonsAsyncAction.run(() => super._getPokemons());
  }

  final _$_getPokemonCardDataAsyncAction =
      AsyncAction('_HomeController._getPokemonCardData');

  @override
  Future _getPokemonCardData() {
    return _$_getPokemonCardDataAsyncAction
        .run(() => super._getPokemonCardData());
  }

  final _$searchPokemonAsyncAction =
      AsyncAction('_HomeController.searchPokemon');

  @override
  Future searchPokemon() {
    return _$searchPokemonAsyncAction.run(() => super.searchPokemon());
  }

  final _$refreshPokemonsListAsyncAction =
      AsyncAction('_HomeController.refreshPokemonsList');

  @override
  Future refreshPokemonsList({bool refreshAll = false}) {
    return _$refreshPokemonsListAsyncAction
        .run(() => super.refreshPokemonsList(refreshAll: refreshAll));
  }

  final _$_loadFavoritesListAsyncAction =
      AsyncAction('_HomeController._loadFavoritesList');

  @override
  Future _loadFavoritesList() {
    return _$_loadFavoritesListAsyncAction
        .run(() => super._loadFavoritesList());
  }

  final _$setFavoritesAsyncAction = AsyncAction('_HomeController.setFavorites');

  @override
  Future setFavorites(String key, bool value) {
    return _$setFavoritesAsyncAction.run(() => super.setFavorites(key, value));
  }

  final _$_setFilteredPokemonsAsyncAction =
      AsyncAction('_HomeController._setFilteredPokemons');

  @override
  Future _setFilteredPokemons(String key) {
    return _$_setFilteredPokemonsAsyncAction
        .run(() => super._setFilteredPokemons(key));
  }

  final _$filterPokemonsAsyncAction =
      AsyncAction('_HomeController.filterPokemons');

  @override
  Future filterPokemons() {
    return _$filterPokemonsAsyncAction.run(() => super.filterPokemons());
  }

  final _$changeToFilteredAsyncAction =
      AsyncAction('_HomeController.changeToFiltered');

  @override
  Future changeToFiltered() {
    return _$changeToFilteredAsyncAction.run(() => super.changeToFiltered());
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  dynamic setSearchText(String text) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setErrorMessage(String errorText) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController._setErrorMessage');
    try {
      return super._setErrorMessage(errorText);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic saveFavorites(PokemonModel poke) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.saveFavorites');
    try {
      return super.saveFavorites(poke);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
textController: ${textController},
isSearching: ${isSearching},
isFiltering: ${isFiltering},
isLoading: ${isLoading},
error: ${error},
errorMessage: ${errorMessage},
pokemonsFiltered: ${pokemonsFiltered},
pokemons: ${pokemons},
pokemonsData: ${pokemonsData},
showSuffix: ${showSuffix},
disableButtons: ${disableButtons}
    ''';
  }
}
