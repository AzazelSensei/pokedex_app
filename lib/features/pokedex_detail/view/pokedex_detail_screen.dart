import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pokedex_list/cubit/pokedex_list_cubit.dart';
import '../../pokedex_list/model/pokedex_list_model.dart';
import '../cubit/pokedex_detail_cubit.dart';
import 'package:pokedex_app/core/extension/letter_extension.dart';

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
                  // Status bar color
                  statusBarColor: Colors.transparent,

                  // Status bar brightness (optional)
                  statusBarIconBrightness:
                      Brightness.dark, // For Android (dark icons)
                  statusBarBrightness: Brightness.light, // For iOS (dark icons)
                ),
                elevation: 0,
                centerTitle: true,
                title: Text(widget.result.name!.toUpperCase()),
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
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              elevation: 2,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Abilities",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        state.detail.abilities![index].ability!.name!
                            .toTitleCase(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Forms",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      state.detail.forms![index].name!.toTitleCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Base Experience",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Versions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      state.detail.gameIndices![index].version!.name!
                          .toTitleCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Height",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      state.detail.height.toString().toTitleCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "ID",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                Text(
                  state.detail.id.toString().toTitleCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          // Card(
          //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //   shape: RoundedRectangleBorder(
          //     side: BorderSide(
          //       color: Theme.of(context).colorScheme.outline,
          //     ),
          //     borderRadius: const BorderRadius.all(Radius.circular(12)),
          //   ),
          //   elevation: 2,
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 10),
          //       const Text(
          //         "Held Items",
          //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          //       ),
          //       const SizedBox(height: 10),
          //       const Divider(
          //         height: 1,
          //         color: Colors.black54,
          //       ),
          //       const SizedBox(height: 10),
          //       ListView.builder(
          //         physics: const NeverScrollableScrollPhysics(),
          //         shrinkWrap: true,
          //         itemCount: state.detail.heldItems?.length,
          //         itemBuilder: (context, index) => SizedBox(
          //           height: 200,
          //           child: Center(
          //             child: Text(
          //               state.detail.heldItems![index] ,
          //               style: Theme.of(context).textTheme.headline6,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 10),
          //     ],
          //   ),
          // ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Is Default",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      //eğer true ise şunu yaz

                      state.detail.isDefault.toString().toTitleCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Moves",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                if (state.detail.moves!.length <= 5)
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.detail.moves!.length,
                      itemBuilder: (context, index) => Center(
                            child: Text(
                              state.detail.moves![index].move!.name
                                  .toString()
                                  .toTitleCase(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ))
                else if (state.detail.moves!.length >= 5)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Center(
                      child: Text(
                        //eğer true ise şunu yaz

                        state.detail.moves![index].move!.name
                            .toString()
                            .toTitleCase(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Order",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                Text(
                  //eğer null dönerse şunu yap
                  state.detail.order.toString().toTitleCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Past Types",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  itemCount: state.detail.pastTypes!.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      //eğer true ise şunu yaz

                      state.detail.pastTypes![index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Sprites",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                _rowMet(state),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Stats",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  itemCount: state.detail.stats!.length,
                  itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.detail.stats![index].stat!.name
                              .toString()
                              .toCapitalized(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Text(" - "),
                        Text(
                          state.detail.stats![index].baseStat.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ]),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Types",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  itemCount: state.detail.types!.length,
                  itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.detail.types![index].type!.name.toString() ==
                            "water")
                          const Icon(Icons.water)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "psychic")
                          const Icon(Icons.horizontal_split)
                        else if (state
                                .detail.types![index].type!.name
                                .toString() ==
                            "grass")
                          const Icon(Icons.grass)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "fire")
                          const Icon(Icons.local_fire_department)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "poison")
                          const Icon(Icons.warning)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "flying")
                          const Icon(Icons.air)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "normal")
                          const Icon(Icons.developer_mode_outlined)
                        else if (state.detail.types![index].type!.name
                                .toString() ==
                            "bug")
                          const Icon(Icons.bug_report),
                        const Text(" - "),
                        Text(
                          state.detail.types![index].type!.name
                              .toString()
                              .toCapitalized(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ]),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 2,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Weight",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                Text(
                  state.detail.weight.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
              ],
            ),
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
}
