part of 'pokedex_list_cubit.dart';

@immutable
abstract class PokedexListState {}

class PokedexListInitial extends PokedexListState {}

class PokedexListLoading extends PokedexListState {}

class PokedexListLoaded extends PokedexListState {
  final List<Result> pokemons;

  PokedexListLoaded(this.pokemons);
}

class PokedexListError extends PokedexListState {
  final String errorMessage;

  PokedexListError(this.errorMessage);
}

class LazyLoadedState<Result> extends PokedexListState {
  final Result data;
  final bool hasReachedMax;
  final bool? lazyError;

  LazyLoadedState(this.data, this.hasReachedMax, this.lazyError,);

  LazyLoadedState<Result> copyWith({
    Result? data,
    bool? hasReachedMax,
    bool? lazyError,
  }) {
    return LazyLoadedState(
      data ?? this.data,
      hasReachedMax ?? this.hasReachedMax,
      lazyError ?? this.lazyError,
    );
  }
}
