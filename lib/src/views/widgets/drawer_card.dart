import 'package:flutter/material.dart';

class DrawerCard extends StatefulWidget {
  final String title;
  final Icon icon;
  final VoidCallback? onTap;
  const DrawerCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 6, left: 8, right: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: widget.icon,
        title: Text(widget.title),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
      ),
    );
  }
}
