import 'dart:io';

import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/core/util/p_utils.dart';


class CacheManagerListTile extends StatefulWidget {
  final String cacheDirPath;
  const CacheManagerListTile({super.key, required this.cacheDirPath});

  @override
  State<CacheManagerListTile> createState() => _CacheManagerListTileState();
}

class _CacheManagerListTileState extends State<CacheManagerListTile> {
  @override
  void didUpdateWidget(covariant CacheManagerListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  bool needToClean = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showCaleanConfirm,
      child: FutureBuilder(
        future: PUtils.getFolderInfo(Directory(widget.cacheDirPath)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == .waiting) {
            return _body('Loading...', '....');
          }
          final data = snapshot.data;
          if (data == null) return SizedBox.shrink();
          if (data.$1 == 0) return SizedBox.shrink();

          needToClean = data.$2 > 0;

          return _body(data.$1.toString(), data.$2.fileSizeLabel());
        },
      ),
    );
  }

  Widget _body(String count, String size) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: .symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: .45,
        ),
        borderRadius: .circular(15),
      ),
      child: Row(
        spacing: 10,
        children: [
          Icon(Icons.cleaning_services_outlined, color: colorScheme.primary),
          Column(
            crossAxisAlignment: .start,
            children: [
              const Text(
                'Clear cache',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                '$count files • $size',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Spacer(),
          const Icon(Icons.delete_outline_rounded),
        ],
      ),
    );
  }

  void _showCaleanConfirm() {
    showClearCacheDialog(
      context: context,
      onClear: () async {
        await PUtils.deleteFolder(Directory(widget.cacheDirPath));
        if (!mounted) return;
        setState(() {});
      },
    );
  }

  Future<void> showClearCacheDialog({
    required BuildContext context,
    required Future<void> Function() onClear,
  }) async {
    final colorScheme = Theme.of(context).colorScheme;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.cleaning_services_outlined,
            size: 32,
            color: colorScheme.primary,
          ),
          title: const Text('Clear cache?', textAlign: TextAlign.center),
          content: const Text(
            'Cached files will be removed.\n'
            'Your original files will not be affected.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await onClear();
              },
              child: const Text('Clear Cache'),
            ),
          ],
        );
      },
    );
  }
}

/*
 contentText: 'သိမ်းထားတဲ့ cache ဖိုင်တွေကို ရှင်းမှာသေချာပါသလား?\n\n'
      'မူရင်းဖိုင်တွေကို ထိခိုက်မှာမဟုတ်ပါ။',
  submitText: 'Clear Cache',
 */
