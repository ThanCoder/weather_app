import 'package:flutter/material.dart';

import '../../dialogs/index.dart';
import '../../models/index.dart';
import '../../widgets/index.dart';

class GenresComponent extends StatefulWidget {
  String genres;
  void Function(String genres) onChange;
  GenresComponent({super.key, required this.genres, required this.onChange});

  @override
  State<GenresComponent> createState() => _GenresComponentState();
}

class _GenresComponentState extends State<GenresComponent> {
  List<String> genresList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    final list = widget.genres.split(',').where((tx) => tx.isNotEmpty).toList();

    setState(() {
      genresList = list;
    });
  }

  void _delGenres(String title) async {
    genresList = genresList.where((str) => str != title).toList();
    setState(() {});
    widget.onChange(genresList.join(','));
  }

  void _addGenres() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GenresFormDialog(
        genresList: [],
        onAddGenres: (GenresModel genres) {
          print(genres);
        },
        onDeleteGenres: (GenresModel genres) {
          print(genres);
        },
        existsList: genresList,
        onCancel: () {},
        onSubmit: (genres) {
          setState(() {
            genresList = genres;
          });
          widget.onChange(genres.join(','));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (genresList.isNotEmpty)
              ...genresList.map(
                (str) => TChip(
                  title: str,
                  onDelete: () => _delGenres(str),
                ),
              ),

            //add
            IconButton(
              color: Colors.teal[900],
              onPressed: _addGenres,
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
      ],
    );
  }
}
