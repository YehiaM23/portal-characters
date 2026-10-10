import 'package:flutter/material.dart';
import 'package:project1/data/models/charachters.dart';

class CharachterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharachterDetailsScreen({super.key, required this.character});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(character.name)),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                character.img,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (_, error, stack) => const SizedBox(
                  height: 200,
                  child: Icon(Icons.person, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              character.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            for (final item in [
              'Status: ${character.status}',
              'Species: ${character.species}',
              'Gender: ${character.gender}',
              'Origin: ${character.origin}',
              'Location: ${character.location}',
            ])
              Card(child: ListTile(title: Text(item))),
          ],
        ),
      ),
    ),
  );
}
