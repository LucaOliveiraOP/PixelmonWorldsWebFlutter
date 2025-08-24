import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlayerHead extends StatefulWidget {
  final String username;
  const PlayerHead({super.key, required this.username});

  @override
  State<PlayerHead> createState() => _PlayerHeadState();
}

class _PlayerHeadState extends State<PlayerHead> {
  // Nomes permitidos
  final List<String> fallbackNames = ['Steve', 'Notch', 'Herobrine'];
  String displayedName = 'Steve';

  @override
  void initState() {
    super.initState();
    // Sorteia um nome da lista para exibir enquanto carrega ou se falhar
    displayedName = (fallbackNames..shuffle()).first;
    _resolveUsername(widget.username);
  }

  Future<void> _resolveUsername(String username) async {
    try {
      final url = Uri.parse('https://api.ashcon.app/mojang/v2/user/$username');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final validName = data['username'] as String;
        setState(() {
          displayedName = validName;
        });
      }
    } catch (_) {
      // Em caso de erro, o nome sorteado permanece
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        'https://minotar.net/avatar/$displayedName/50',
        width: 50,
        height: 50,
        errorBuilder: (_, __, ___) => const Icon(Icons.person),
      ),
    );
  }
}
