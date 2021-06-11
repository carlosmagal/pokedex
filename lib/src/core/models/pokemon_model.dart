import 'package:flutter/material.dart';
import 'package:pokedex_app/src/core/utils/shared/colors_util.dart';
import 'package:pokedex_app/src/core/utils/shared/constants.dart';

class PokemonModel {

  String? name;
  int? id;
  String? imgUrl;
  List<dynamic>? types;
  Map<String, dynamic>? stats;
  Color? color;
  bool? isFavorite;

  PokemonModel({
    this.name,
    this.id,
    this.imgUrl,
    this.types,
    this.stats,
  });

  PokemonModel.map(Map<String, dynamic> json, bool value) {
    this.name = json['name'];
    this.id = json['id'];
    this.imgUrl = json['sprites']['other']['official-artwork']['front_default'] ?? defaultImageUrl;
    this.types = this._getTypes(json['types']);
    this.stats = this._getStats(json['stats']);
    this.color = ColorsUtil.colorByType[this.types!.first] ?? ColorsUtil.colorless;
    this.isFavorite = value;
  }

  PokemonModel.fromFavoritesMap(Map<String, dynamic> pokemon){
    this.name = pokemon['name'];
    this.id = pokemon['id'];
    this.imgUrl = pokemon['imgUrl'];
    this.types = pokemon['types'];
    this.stats = pokemon['stats'];
    this.color = ColorsUtil.colorByType[this.types!.first] ?? ColorsUtil.colorless;
    this.isFavorite = pokemon['isFavorite'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['name'] = this.name;
    map['imgUrl'] = this.imgUrl;
    map['id'] = this.id;
    map['types'] = this.types;
    map['stats'] = this.stats;
    map['isFavorite'] = this.isFavorite;
    return map;
  }

  List<String> _getTypes( List<dynamic> pokemonTypes){
    List<String> typeList = [];

    for(var element in pokemonTypes){
      typeList.add(element['type']['name']);
    }

    return typeList;
  }

  Map<String, dynamic> _getStats(List<dynamic> pokemonStats){

    return {
      'HP': pokemonStats[0]['base_stat'],
      'Attack': pokemonStats[1]['base_stat'],
      'Defense': pokemonStats[2]['base_stat'],
      'Special-Attack': pokemonStats[3]['base_stat'],
      'Special-Defense': pokemonStats[4]['base_stat'],
      'Speed': pokemonStats[5]['base_stat'],
    };
  }

  @override 
  String toString(){
    return 'PokemonModel: {name: ${this.name}, imgUrl: ${this.imgUrl}, id: ${this.id}, types: ${this.types}, stats: ${this.stats}';
  }

}

//'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(this.id).toString()}.png'