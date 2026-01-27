
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomCard({super.key, required this.icon, required this.title, required this.subtitle, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 45,vertical: 5),
        child: InkWell(
          onTap: onTap,
          child: Column(
          children: [
             ListTile(
              leading: Icon(icon),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600
                ),
                ),
              subtitle: Text(subtitle),
              trailing: onTap != null
              ? const Icon(Icons.chevron_right)
              : null,
            )
          ],
          )
        ),
    );
  }
}