import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ColorsUtil {
  static final white = Colors.white;
  static final black = Colors.black;

  static final cinzaEscuro = utilsPlus.colorHex('#4A4A4A');
  static final background = utilsPlus.colorHex('#FCFCFC');
  static final headerBackground = utilsPlus.colorHex('#FFFFFF');
  static final textField = utilsPlus.colorHex('#F7F7F7');
  static final textFieldIcon = utilsPlus.colorHex('#CCCCCC');
  static final status = utilsPlus.colorHex('#4A4A4A');
  static final statusLinearProgress = utilsPlus.colorHex('#FB6C6C');

  static final typeCard = Color.fromRGBO(255, 255, 255, 0.3);
  static final pokeballRed = utilsPlus.colorHex('#FE3E31');

  static final colorless = utilsPlus.colorHex('#E5D6D0');

  static final Map<String, Color> colorByType = {
    'bug': utilsPlus.colorHex('#A8B820'),
    'dark': utilsPlus.colorHex('#705848'),
    'dragon': utilsPlus.colorHex('#7038F8'),
    'electric': utilsPlus.colorHex('#F8D030'),
    'fairy': utilsPlus.colorHex('#EE99AC'),
    'fighting': utilsPlus.colorHex('#C03028'),
    'fire': utilsPlus.colorHex('#F08030'),
    'flying': utilsPlus.colorHex('#A890F0'),
    'ghost': utilsPlus.colorHex('#705898'),
    'grass': utilsPlus.colorHex('#78C850'),
    'ground': utilsPlus.colorHex('#E0C068'),
    'ice': utilsPlus.colorHex('#98D8D8'),
    'normal': utilsPlus.colorHex('#A8A878'),
    'poison': utilsPlus.colorHex('#A040A0'),
    'psychic': utilsPlus.colorHex('#F85888'),
    'rock': utilsPlus.colorHex('#B8A038'),
    'steel': utilsPlus.colorHex('#B8B8D0'),
    'water': utilsPlus.colorHex('#6890F0'),
  };

  static final Map<String, Color> colorByStats = {
    'HP': utilsPlus.colorHex('#FF0000'),
    'Attack': utilsPlus.colorHex('#F08030'),
    'Defense': utilsPlus.colorHex('#F8D030'),
    'Special-Attack': utilsPlus.colorHex('#6890F0'),
    'Special-Defense': utilsPlus.colorHex('#78C850'),
    'Speed': utilsPlus.colorHex('#F85888'),
  };

}
