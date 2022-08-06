// import 'package:flutter/material.dart';
// import 'package:pokedex_app/features/pokedex_detail/model/pokedex_detail_model.dart';

// import '../../pokedex_list/model/pokedex_list_model.dart';

// class PokedexDetailCard extends StatelessWidget {
//   const PokedexDetailCard(
//       {Key? key, required this.text, required this.count})
//       : super(key: key);
//   final String text;
//   final int count;

//   @override
//   Widget build(BuildContext context) {
//     Card PokedexDetailCardAll(PokedexDetailLoaded state) {
//     return Card(
//           margin: EdgeInsets.all(20),
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: Theme.of(context).colorScheme.outline,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//           ),
//           elevation: 10,
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 "Abilities",
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               SizedBox(height: 10),
//               Divider(height: 1),
//               SizedBox(height: 10),
//               ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: state.detail.abilities?.length,
//                 itemBuilder: (context, index) => Center(
//                   child: Text(
//                     state.detail.abilities![index].ability!.name!,
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ));
//   }
//   }
// }
