import 'api_service.dart';

class PokedexService {
  Future<dynamic> getPokemons(int offset, int limit) {
    return apiService.request(
      HttpMethod.GET,
      'pokemon/?offset=$offset&limit=$limit',
    ).then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> getPokemonByName(String? name) {
    return apiService.request(
      HttpMethod.GET,
      'pokemon/${name??''}',
    ).then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }
}
