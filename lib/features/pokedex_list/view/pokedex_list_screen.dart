import 'package:flutter/material.dart';

import '../cubit/pokedex_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../widget/pokedex_card.dart';

class PokedexListScreen extends StatefulWidget {
  const PokedexListScreen({Key? key}) : super(key: key);

  @override
  State<PokedexListScreen> createState() => _PokedexListScreenState();
}

class _PokedexListScreenState extends State<PokedexListScreen> {
  final limit = 20;
  bool isLazyLoad = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PokedexListCubit>().getPokemonList(limit);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() async {
    if (isLazyLoad) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (maxScroll - currentScroll <= 500) {
        isLazyLoad = false;
        lazyLoad();
      }
    }
  }

  void lazyLoad() => context.read<PokedexListCubit>().getPokemonList(limit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex List'),
      ),
      body: BlocBuilder<PokedexListCubit, PokedexListState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, state) {
    if (state is LazyLoadedState<PokedexListCubit?>) {
      return _listView(state.data!, state.hasReachedMax, state.lazyError);
    } else if (state is PokedexListLoaded) {
      return LazyLoadScrollView(
        onEndOfPage: () {
          _onScroll();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: state.pokemons.length,
          itemBuilder: (context, index) {
            return PokedexCard(
              result: state.pokemons[index],
              index: index + 1,
            );
          },
        ),
      );
    } else if (state is PokedexListError) {
      return const Center(
        child: Text('Error'),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _listView(state, bool hasReachedMax, bool? lazyError) {
    isLazyLoad = true;
    final pokemons = state.pokemons;

    if (pokemons != null && pokemons.isNotEmpty) {
      return Scrollbar(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: pokemons.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (context, index) {
            return PokedexCard(
              result: pokemons[index],
              index: index + 1,
            );
          },
        ),
      );
    } else {
      return const Center(
        child: Text('No pokemons'),
      );
    }
  }

  Widget get lazyTryAgainBtn =>
      TextButton(onPressed: () {}, child: const Text('Try again'));
}
