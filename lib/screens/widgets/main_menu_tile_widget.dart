import 'package:flutter/material.dart';

class MainMenuTileWidget extends StatelessWidget {
  const MainMenuTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed, required this.iconColor,
  });
  final IconData icon;
  final String title;
  final Function onPressed;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () {
        onPressed();
      },
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      leading: Icon(
        icon,
        color: iconColor,
        size: 28,
      ),
      
    );
  }
}
