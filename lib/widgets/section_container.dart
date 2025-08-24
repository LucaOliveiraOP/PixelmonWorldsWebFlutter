import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionContainer extends StatefulWidget {
  final String title;
  final String content;
  final IconData? icon;
  final VoidCallback? onTap;

  const SectionContainer({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    this.onTap,
  });

  @override
  State<SectionContainer> createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = _hovering ? Colors.red : Colors.white24;
    final iconColor = _hovering ? Colors.red : Colors.white;
    final titleColor = _hovering ? Colors.red : Colors.white;

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return InkWell(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isMobile ? double.infinity : 480,
          constraints: BoxConstraints(
            minHeight: isMobile ? 140 : 280, // reduzido para mobile
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 16 : 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: isMobile ? 30 : 48, // menor no mobile
                  color: iconColor,
                ),
                SizedBox(height: isMobile ? 8 : 16), // menor espaçamento
              ],
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    color: titleColor,
                    fontSize: isMobile ? 11 : 14,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 16), // menor espaçamento
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    color: titleColor,
                    fontSize: isMobile ? 8 : 14,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                child: Text(
                  widget.content,
                  maxLines: isMobile ? 3 : 5, // menos linhas no mobile
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
