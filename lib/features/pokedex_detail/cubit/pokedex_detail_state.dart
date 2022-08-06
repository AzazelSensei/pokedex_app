part of 'pokedex_detail_cubit.dart';

@immutable
abstract class PokedexDetailState {}

class PokedexDetailInitial extends PokedexDetailState {}

class PokedexDetailLoaded extends PokedexDetailState {
  final PokodexDetail detail;

  PokedexDetailLoaded(this.detail);
}

class PokedexDetailLoading extends PokedexDetailState {}

class PokedexDetailError extends PokedexDetailState {
  final String errorMessage;
  PokedexDetailError(this.errorMessage);
}
