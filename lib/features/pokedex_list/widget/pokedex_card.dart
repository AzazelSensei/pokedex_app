import 'package:flutter/material.dart';
import 'package:pokedex_app/features/pokedex_detail/view/pokedex_detail_screen.dart';
import 'package:pokedex_app/network/endpoint.dart';
import 'package:pokedex_app/core/extension/ui_extension.dart';

import '../model/pokedex_list_model.dart';

class PokedexCard extends StatelessWidget {
  const PokedexCard({Key? key, required this.result, required this.index})
      : super(key: key);
  final Result result;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokedexDetailScreen(
              context,
              index: index,
              result: result,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 10,
          child: Center(
            child: Column(
              children: [
                //image
                SizedBox(
                    height: context.normalWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(EndPoint.getPokemonImageUrl(index)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      style: Theme.of(context).textTheme.headline6,
                      result.name ?? ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
