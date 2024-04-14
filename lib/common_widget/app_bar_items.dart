import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:ui_samples/constant/ui_const.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: Navigator.of(context).pop,
      padding: EdgeInsets.zero,
      icon: const Iconify(
        Ph.arrow_left_bold,
        color: primaryColor,
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle(this.title, [this.subtitle]);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (subtitle != null)
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
          ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: subtitle == null ? 20 : 16,
              ),
        ),
      ],
    );
  }
}

class AppBarInfo extends StatelessWidget {
  const AppBarInfo({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: message,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 5),
          child: const Row(
            children: [
              Iconify(
                Ph.info_bold,
                color: primaryColor,
              ),
            ],
          ),
        ),
        const Gap(mainHorizontalPadding),
      ],
    );
  }
}
