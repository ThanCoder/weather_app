import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../components/index.dart';
import '../../models/index.dart';
import '../../widgets/index.dart';

class GenresFormDialog extends StatefulWidget {
  final String cancelText;
  final String submitText;
  final List<String> existsList;
  final List<GenresModel> genresList;
  final void Function() onCancel;
  final void Function(List<String> genres) onSubmit;
  final void Function(GenresModel genres) onAddGenres;
  final void Function(GenresModel genres) onDeleteGenres;

  const GenresFormDialog({
    super.key,
    required this.genresList,
    required this.onCancel,
    required this.onSubmit,
    required this.onAddGenres,
    required this.onDeleteGenres,
    this.cancelText = 'Cancel',
    this.submitText = 'Choose',
    this.existsList = const [],
  });

  @override
  State<GenresFormDialog> createState() => _GenresFormDialogState();
}

class _GenresFormDialogState extends State<GenresFormDialog> {
  final TextEditingController titleController = TextEditingController();
  List<String> chooseList = [];
  List<GenresModel> genresList = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    init(); // Async Method
  }

  Future<void> init() async {
    titleController.text = 'Untitled';
    if (mounted) {
      setState(() {
        genresList = widget.genresList;
      });
    }
    _titleChanged(titleController.text);
    _checkExistList();
  }

  void _checkExistList() {
    final res = genresList.map((gen) {
      if (widget.existsList.contains(gen.title)) {
        gen.isSelected = true;
      } else {
        gen.isSelected = false;
      }
      return gen;
    }).toList();
    setState(() {
      genresList = res;
    });
  }

  void _titleChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        errorMessage = 'တစ်ခုခုဖြည့်ပေးရပါမယ်!';
      });
      return;
    }
    //check already genres
    final resList = genresList.where((gen) => gen.title == text).toList();
    if (resList.isEmpty) {
      setState(() {
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = 'ရှိနေပြီးသား ဖြစ်နေပါတယ်!';
      });
    }
  }

  void _addGenres() async {
    if (errorMessage != null) {
      return;
    }
    final genres = GenresModel(
      id: Uuid().v4(),
      title: titleController.text,
      date: DateTime.now().millisecondsSinceEpoch,
    );
    final res = genresList;
    res.insert(0, genres);
    setState(() {
      genresList = res;
    });
    widget.onAddGenres(genres);
    //clear field
    titleController.text = '';
    _titleChanged(titleController.text);
    _checkExistList();
  }

  void _choose() {
    chooseList.clear();
    for (var gen in genresList) {
      if (gen.isSelected) {
        chooseList.add(gen.title);
      }
    }
    widget.onSubmit(chooseList);
  }

  void _delGenres(GenresModel genres) async {
    final res = genresList.where((gen) => gen.title != genres.title).toList();
    setState(() {
      genresList = res;
    });
    widget.onDeleteGenres(genres);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Genres From Dialog'),
      content: SizedBox(
        width: double.maxFinite, // Dialog Width ကို Responsive ဖြစ်အောင်
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column ကို Auto-Shrink ဖြစ်အောင်
          children: [
            // Add form
            Row(
              children: [
                Expanded(
                  child: TTextField(
                    label: const Text('Genres Title'),
                    controller: titleController,
                    errorText: errorMessage,
                    onChanged: _titleChanged,
                  ),
                ),
                IconButton(
                  color: Colors.teal[900],
                  onPressed: errorMessage == null ? _addGenres : null,
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // List View with shrinkWrap
            Expanded(
              child: GenresListView(
                genresList: genresList,
                onClick: (genres) {},
                onDeleted: _delGenres,
                onSelectChanged: (genres, isSelected) {
                  final res = genresList.map((gen) {
                    if (gen.title == genres.title) {
                      gen.isSelected = isSelected;
                      return gen;
                    }
                    return gen;
                  }).toList();
                  setState(() {
                    genresList = res;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onCancel();
          },
          child: Text(widget.cancelText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            _choose();
          },
          child: Text(widget.submitText),
        ),
      ],
    );
  }
}
