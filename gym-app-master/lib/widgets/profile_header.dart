import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    required this.onEdit,
    required this.onImageTap,
  });

  final String name;
  final String email;
  final String? imageUrl;
  final VoidCallback onEdit;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: onImageTap,
              child: CircleAvatar(
                radius: 34,
                backgroundImage:
                    imageUrl != null && imageUrl!.isNotEmpty ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null || imageUrl!.isEmpty
                    ? const Icon(Icons.person, size: 34)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  Text(email, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
          ],
        ),
      ),
    );
  }
}
