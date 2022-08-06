import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pokedex_list/cubit/pokedex_list_cubit.dart';
import '../../pokedex_list/model/pokedex_list_model.dart';
import '../cubit/pokedex_detail_cubit.dart';

class PokedexDetailScreen extends StatefulWidget {
  const PokedexDetailScreen(BuildContext context,
      {Key? key, required this.index, required this.result})
      : super(key: key);
  final int index;
  final Result result;

  @override
  State<PokedexDetailScreen> createState() => _PokedexDetailScreenState();
}

class _PokedexDetailScreenState extends State<PokedexDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokedexDetailCubit>().getPokemonDetail(
          widget.index + 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokedexListCubit, PokedexListState>(
      listener: (context, state) {},
      child: BlocBuilder<PokedexDetailCubit, PokedexDetailState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.result.name ?? ""),
              ),
              body: BlocBuilder<PokedexDetailCubit, PokedexDetailState>(
                builder: (context, state) {
                  if (state is PokedexDetailLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PokedexDetailLoaded) {
                    return _body(state);
                  } else if (state is PokedexDetailError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  } else {
                    return const Center(
                      child: Text('Unknown state'),
                    );
                  }
                },
              ));
        },
      ),
    );
  }

  Widget _body(PokedexDetailLoaded state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              elevation: 5,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Abilities",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.detail.abilities?.length,
                    itemBuilder: (context, index) => Center(
                      child: Text(
                        state.detail.abilities![index].ability!.name!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Forms",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.detail.forms?.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      state.detail.forms![index].name!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Base Experience",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      state.detail.baseExperience.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Versions",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.detail.species!.name!.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      state.detail.gameIndices![index].version!.name!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Height",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      state.detail.height.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
