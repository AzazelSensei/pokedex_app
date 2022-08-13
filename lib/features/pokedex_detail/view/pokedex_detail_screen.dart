import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pokedex_list/cubit/pokedex_list_cubit.dart';
import '../../pokedex_list/model/pokedex_list_model.dart';
import '../cubit/pokedex_detail_cubit.dart';
import 'package:pokedex_app/core/extension/letter_extension.dart';

import '../widget/properties_card.dart';

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
          widget.index,
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
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                elevation: 0,
                centerTitle: true,
                title: Text(widget.result.name!.toUpperCase()),
              ),
              body: _stateRouter,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_back),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat);
        },
      ),
    );
  }

  Widget get _stateRouter =>
      BlocBuilder<PokedexDetailCubit, PokedexDetailState>(
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
      );

  Widget _body(PokedexDetailLoaded state) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          PropertiesCard(
            title: "Abilities",
            contentlist: state.detail.abilities!
                .map((e) => e.ability?.name ?? "")
                .toList(),
          ),
          PropertiesCard(
            title: "Forms",
            contentlist: state.detail.forms!.map((e) => e.name ?? "").toList(),
          ),
          PropertiesCard(
            title: "Base Experience",
            contentlist: [state.detail.baseExperience.toString()],
          ),
          PropertiesCard(
            title: "Versions",
            contentlist: state.detail.gameIndices!
                .map((e) => e.version?.name ?? "")
                .toList(),
          ),
          PropertiesCard(
            title: "Height",
            contentlist: [state.detail.height.toString()],
          ),
          PropertiesCard(
            title: "ID",
            contentlist: [state.detail.id.toString()],
          ),
          PropertiesCard(
            title: "Is Default",
            contentlist: [state.detail.isDefault.toString()],
          ),
          PropertiesCard(
            title: "Moves",
            contentlist:
                state.detail.moves!.map((e) => e.move?.name ?? "").toList(),
          ),
          PropertiesCard(
            title: "Order",
            contentlist: [state.detail.order.toString()],
          ),
          PropertiesCard(
            title: "Sprites",
            contentWidget: Column(
              children: [
                _rowMet(state),
              ],
            ),
          ),
          PropertiesCard(
            title: "Stats",
            contentlist: state.detail.stats!
                .map((e) => "${e.stat?.name ?? ""} - ${e.baseStat}")
                .toList(),
          ),
          PropertiesCard(
            title: "Types",
            contentWidget: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.detail.types!.length,
              itemBuilder: (context, index) =>
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _iconType(state.detail.types![index].type?.name ?? ""),
                const Text(" - "),
                Text(
                  state.detail.types![index].type!.name
                      .toString()
                      .toCapitalized(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ]),
            ),
          ),
          PropertiesCard(
            title: "Weight",
            contentlist: [state.detail.weight.toString()],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Row _rowMet(PokedexDetailLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          state.detail.sprites!.backDefault.toString(),
        ),
        Image.network(
          state.detail.sprites!.backShiny.toString(),
        ),
        const VerticalDivider(
          thickness: 1,
          color: Colors.black,
        ),
        Image.network(
          state.detail.sprites!.frontDefault.toString(),
        ),
        Image.network(
          state.detail.sprites!.frontShiny.toString(),
        ),
      ],
    );
  }

  Widget _iconType(String typeName) {
    if (typeName == "water") {
      return const Icon(Icons.water);
    } else if (typeName == "psychic") {
      return const Icon(Icons.horizontal_split);
    } else if (typeName == "grass") {
      return const Icon(Icons.grass);
    } else if (typeName == "fire") {
      return const Icon(Icons.local_fire_department);
    } else if (typeName == "poison") {
      return const Icon(Icons.warning);
    } else if (typeName == "flying") {
      return const Icon(Icons.air);
    } else if (typeName == "normal") {
      return const Icon(Icons.developer_mode_outlined);
    } else if (typeName == "bug") {
      return const Icon(Icons.bug_report);
    } else {
      return const SizedBox();
    }
  }
}
