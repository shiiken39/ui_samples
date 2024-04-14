import 'package:flutter/material.dart';
import 'package:ui_samples/common_widget/app_bar_items.dart';
import 'package:ui_samples/common_widget/carousel.dart';
import 'package:ui_samples/constant/ui_const.dart';
import 'package:ui_samples/model/head_light_type.dart';

/// カルーセルサンプル画面
class CarouselScreen extends StatelessWidget {
  const CarouselScreen(this.title);

  final String title;

  static Route<dynamic> route(String title) {
    return MaterialPageRoute(
      builder: (_) => CarouselScreen(title),
    );
  }

  static Future<void> push(BuildContext context, String title) async {
    await Navigator.push(context, route(title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: AppBarTitle(title),
        actions: const [
          AppBarInfo(
            message: '機能'
                '\n1. 左右にドラッグして変更'
                '\n2. 左右の要素をタップして変更',
          ),
        ],
      ),
      body: const SafeArea(child: _Content()),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Divider(),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Carousel(
            viewportFraction: 0.8,
            initialPage: 1,
            onPageChanged: (_) {},
            children: HeadLightMode.values.map((mode) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(commonBorderRadius),
                  ),
                  child: Image.network(mode.placeholderImage),
                ),
              );
            }).toList(),
          ),
        ),
        const _Divider(),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 80,
      indent: mainHorizontalPadding,
      endIndent: mainHorizontalPadding,
    );
  }
}
