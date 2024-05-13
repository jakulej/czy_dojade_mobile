import 'package:flutter/material.dart';

class FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;


  const FilterChip({super.key, required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? theme.primaryColor : theme.primaryColorLight,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  isSelected ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
