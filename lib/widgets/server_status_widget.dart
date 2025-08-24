import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServerStatusWidget extends StatefulWidget {
  const ServerStatusWidget({super.key});

  @override
  State<ServerStatusWidget> createState() => _ServerStatusWidgetState();
}

class _ServerStatusWidgetState extends State<ServerStatusWidget> {
  bool _online = false;
  int _players = 0;

  @override
  void initState() {
    super.initState();
    _checkServerStatus();
  }

  Future<void> _checkServerStatus() async {
    try {
      // Conecta no IP local e porta do servidor Minecraft (TCP)
      final socket = await Socket.connect('127.0.0.1', 25565,
          timeout: Duration(seconds: 2));
      socket.destroy();

      // Se conectou, considera online
      setState(() {
        _online = true;
        _players =
            0; // Aqui você pode usar um método real para pegar os jogadores se quiser
      });
    } catch (e) {
      setState(() {
        _online = false;
        _players = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color =
        _online ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7);
    final text = _online
        ? ' $_players jogadores Online nesse momento :)'
        : 'Servidor está offline';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.pressStart2p(
            textStyle: TextStyle(
              color: _online ? Colors.greenAccent : Colors.redAccent,
              fontSize: 10,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
