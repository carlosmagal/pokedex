class PokemonUtils{

  static List<dynamic> getGreaterRatio(Map<String, dynamic> map){
    
    final valuesList = [
      map['HP'] as int,
      map['Attack'] as int,
      map['Defense'] as int,
      map['Special-Attack'] as int,
      map['Special-Defense']as int,
      map['Speed'] as int,
    ];

    final int greater = valuesList.reduce((value, element) => value > element ? value : element);

    if( greater < 100)
      return valuesList;
    
    final List<int> list = [];
    valuesList.forEach((element) {
      if(element != greater)
        list.add(element * greater ~/ 100);
      else
        list.add(element);
    });
    print(greater);
    print(list);
    return list;
  }
}