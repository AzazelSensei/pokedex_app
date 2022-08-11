import 'package:flutter/material.dart';
import 'package:pokedex_app/core/extension/letter_extension.dart';

class PropertiesCard extends StatelessWidget {
  const PropertiesCard({
    Key? key,
    required this.title,
    this.contentlist,
    this.contentWidget,
  }) : super(key: key);

  final String title;
  final List<String>? contentlist;
  final Widget? contentWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
            color: Colors.black54,
          ),
          const SizedBox(height: 10),
          if (contentlist != null && contentWidget == null)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contentlist!.length > 12 ? 12 : contentlist!.length,
              itemBuilder: (context, index) => Center(
                child: Text(
                  contentlist![index].toTitleCase(),
                  
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            )
          else
            contentWidget!,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
