import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:ui_samples/common_widget/app_bar_items.dart';
import 'package:ui_samples/common_widget/common_list_item.dart';
import 'package:ui_samples/constant/ui_const.dart';
import 'package:ui_samples/screen/card_sample_screen.dart';
import 'package:ui_samples/screen/carousel_screen.dart';
import 'package:ui_samples/screen/toggle_button_screen.dart';
import 'package:ui_samples/screen/toggle_carousel_screen.dart';

/// 起動時の最初に表示されるスクリーン
class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('UI サンプル集'),
        centerTitle: false,
        titleSpacing: mainHorizontalPadding + commonBorderRadius,
      ),
      body: const _HomeList(),
    );
  }
}

class _HomeList extends StatelessWidget {
  const _HomeList();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // UI パーツ
        const _HomeListTitle('UI パーツ'),
        _HomeListItem(
          title: 'トグルボタン',
          isFirstChild: true,
          onTap: (title) => ToggleButtonScreen.push(context, title),
        ),
        _HomeListItem(
          title: 'カルーセル',
          onTap: (title) => CarouselScreen.push(context, title),
        ),
        _HomeListItem(
          title: 'トグルボタン&カルーセル',
          isLastChild: true,
          onTap: (title) => ToggleCarouselScreen.push(context, title),
        ),

        // 画面 & 画面遷移
        const _HomeListTitle('画面・画面遷移'),
        _HomeListItem(
          title: 'カード型画面',
          isFirstChild: true,
          isLastChild: true,
          onTap: (title) => CardSampleScreen.push(context),
        ),
      ],
    );
  }
}

class _HomeListTitle extends StatelessWidget {
  const _HomeListTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: mainHorizontalPadding,
        ),
        child: CommonListTitle(title),
      ),
    );
  }
}

class _HomeListItem extends StatelessWidget {
  const _HomeListItem({
    required this.title,
    required this.onTap,
    // ignore: unused_element
    this.hasCaret = true,
    this.isFirstChild = false,
    this.isLastChild = false,
    // ignore: unused_element
    this.subTitle,
  });

  final String title;
  final ValueChanged<String>? onTap;
  final bool hasCaret;
  final bool isFirstChild;
  final bool isLastChild;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: mainHorizontalPadding,
        ),
        child: CommonListItem(
          isFirstChild: isFirstChild,
          isLastChild: isLastChild,
          onTap: () => onTap?.call(title),
          child: Row(
            children: [
              const Gap(16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              if (hasCaret) ...[
                const Iconify(
                  Ph.caret_right_bold,
                  color: secondaryColor,
                  size: 18,
                ),
                const Gap(16),
              ],
              if (subTitle != null) ...[
                Text(
                  subTitle!,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const Gap(24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
