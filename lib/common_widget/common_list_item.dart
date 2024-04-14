import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_samples/constant/ui_const.dart';

class CommonListTitle extends StatelessWidget {
  const CommonListTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(32),
        Row(
          children: [
            const Gap(8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const Gap(4),
      ],
    );
  }
}

class CommonListItem extends StatelessWidget {
  const CommonListItem({
    required this.isFirstChild,
    required this.isLastChild,
    this.onTap,
    this.showDivider = true,
    this.padding,
    this.color,
    required this.child,
    this.coverInkwell = true,
  });

  final bool isFirstChild;
  final bool isLastChild;
  final VoidCallback? onTap;
  final bool showDivider;
  final EdgeInsets? padding;
  final Widget child;
  final Color? color;
  final bool coverInkwell;

  @override
  Widget build(BuildContext context) {
    const radius = commonBorderRadius;
    final borderRadius = BorderRadius.only(
      topLeft: isFirstChild ? const Radius.circular(radius) : Radius.zero,
      topRight: isFirstChild ? const Radius.circular(radius) : Radius.zero,
      bottomLeft: isLastChild ? const Radius.circular(radius) : Radius.zero,
      bottomRight: isLastChild ? const Radius.circular(radius) : Radius.zero,
    );

    if (coverInkwell) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: ColoredBox(
              color: color ?? secondaryBackgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                        padding ?? const EdgeInsets.symmetric(vertical: 12),
                    child: child,
                  ),
                  if (!isLastChild && showDivider)
                    Divider(
                      color: inactiveColor,
                      thickness: 0.5,
                      height: 0,
                    ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              child: InkWell(
                splashColor: commonSplashColor,
                borderRadius: borderRadius,
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: color ?? secondaryBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: InkWell(
            splashColor: commonSplashColor,
            borderRadius: borderRadius,
            onTap: onTap,
            child: Column(
              children: [
                Padding(
                  padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
                  child: child,
                ),
                if (!isLastChild && showDivider)
                  Divider(
                    color: inactiveColor,
                    thickness: 0.5,
                    height: 0,
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
