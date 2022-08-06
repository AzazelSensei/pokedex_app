class EndPoint {
  EndPoint._();
  static const String baseUrl = 'https://pokeapi.co/api/v2/';
  
  static String getPokemonImageUrl(int id) =>
      "https://cdn.traction.one/pokedex/pokemon/$id.png";

  static String getPokemonDetail(int id) =>
      "https://pokeapi.co/api/v2/pokemon/$id";

  static String pokemonEndPoint = 'pokemon';
}
//detail sayfası resimdeki kısım gibi gelecek 
