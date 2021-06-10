class PokemonDTO {
  String? name;
  String? url;

  PokemonDTO({
    this.name,
    this.url,
  });

  PokemonDTO.map(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}
