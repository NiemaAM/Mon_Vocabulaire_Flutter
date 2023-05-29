import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final Color color;
  final IconButton? icon;
  final String? image;
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.automaticallyImplyLeading,
      required this.color,
      this.icon,
      this.image});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: darken(widget.color, .2),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        Container(
            height: 73,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: widget.icon != null
                ? AppBar(
                    automaticallyImplyLeading: widget.automaticallyImplyLeading,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(widget.title),
                    actions: [widget.icon!])
                : widget.image != null
                    ? AppBar(
                        automaticallyImplyLeading:
                            widget.automaticallyImplyLeading,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                widget.image!,
                              ),
                            ),
                            Text("  ${widget.title}"),
                          ],
                        ),
                      )
                    : widget.icon != null && widget.image != null
                        ? AppBar(
                            automaticallyImplyLeading:
                                widget.automaticallyImplyLeading,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    widget.image!,
                                  ),
                                ),
                                Text(widget.title),
                              ],
                            ),
                            actions: [widget.icon!])
                        : AppBar(
                            automaticallyImplyLeading:
                                widget.automaticallyImplyLeading,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text(widget.title),
                          ))
      ],
    );
  }
}
