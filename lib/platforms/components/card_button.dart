import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    this.subTitle,
    this.onRefresh,
    this.bgColor,
  });
  final String title;
  final String? subTitle;
  final void Function()? onRefresh;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final col = Theme.of(context).colorScheme;
    return Container(
      padding: .symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: bgColor ?? col.surfaceContainer,
        border: .all(color: col.outlineVariant),
        borderRadius: .circular(14),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: .w600)),
            if (subTitle != null) SizedBox(height: 10),
            if (subTitle != null)
              Text(
                subTitle!,
                style: TextStyle(fontSize: 16, fontWeight: .w400),
              ),
            if (onRefresh != null) SizedBox(height: 15),
            if (onRefresh != null)
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: col.primaryContainer,
                  foregroundColor: col.onPrimaryContainer,
                ),
                onPressed: onRefresh,
                icon: Icon(Icons.refresh_outlined),
              ),
          ],
        ),
      ),
    );
  }
}
