import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    required this.children,
    this.controller,
    this.viewportFraction,
    this.initialPage,
    this.onPageChanged,
  }) : assert(
          controller == null ||
              (viewportFraction == null && initialPage == null),
          'controllerを指定する場合は、viewportFractionとinitialPageは指定できません',
        );

  final List<Widget> children;
  final PageController? controller;
  final double? viewportFraction;
  final int? initialPage;
  final ValueChanged<int>? onPageChanged;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = widget.controller ??
        PageController(
          viewportFraction: widget.viewportFraction ?? 1,
          initialPage: widget.initialPage ?? 0,
        );
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _pageViewController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageViewController,
      itemCount: widget.children.length,
      onPageChanged: widget.onPageChanged,
      itemBuilder: (BuildContext _, int index) {
        return GestureDetector(
          onTap: () => _pageViewController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: widget.children[index],
        );
      },
    );
  }
}
