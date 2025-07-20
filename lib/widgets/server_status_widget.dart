import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServerStatusWidget extends StatelessWidget {
  final bool online;
  final int players;

  const ServerStatusWidget({
    super.key,
    required this.online,
    this.players = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        online ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7);
    final text = online
        ? ' $players jogadores Online nesse momento :)'
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
              color: online ? Colors.greenAccent : Colors.redAccent,
              fontSize: 10,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
