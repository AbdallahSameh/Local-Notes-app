import 'package:flutter/material.dart';

class ListTransition extends StatefulWidget {
  final int index;
  final Widget child;
  final int itemCount;
  const ListTransition({
    super.key,
    required this.index,
    required this.itemCount,
    required this.child,
  });

  @override
  State<ListTransition> createState() => _ListTransitionState();
}

class _ListTransitionState extends State<ListTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    final tileDuration = 2 / widget.itemCount;
    final start = (widget.index * 0.15).clamp(0.0, 1.0);
    final end = (start + tileDuration).clamp(0.0, 1.0);
    slideAnimation = Tween<Offset>(begin: Offset(1.2, 0), end: Offset(0, 0))
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward(); // start only after first frame is drawn
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: slideAnimation, child: widget.child);
  }
}
