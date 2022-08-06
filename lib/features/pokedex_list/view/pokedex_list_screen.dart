import 'package:flutter/material.dart';

import '../cubit/pokedex_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/pokedex_card.dart';

class PokedexListScreen extends StatefulWidget {
  const PokedexListScreen({Key? key}) : super(key: key);

  @override
  State<PokedexListScreen> createState() => _PokedexListScreenState();
}

class _PokedexListScreenState extends State<PokedexListScreen> {
  final limit = 10;
  @override
  void initState() {
    super.initState();
    context.read<PokedexListCubit>().getPokemonList(limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex List'),
      ),
      body: BlocBuilder<PokedexListCubit, PokedexListState>(
        builder: (context, state) {
          if (state is PokedexListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokedexListLoaded) {
            return ListView.builder(
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                return PokedexCard(
                  result: state.pokemons[index],
                  index: index + 1,
                  
                );
              },
            );
          } else if (state is PokedexListError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}