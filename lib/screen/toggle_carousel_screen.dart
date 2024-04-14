import 'package:flutter/material.dart';
import 'package:ui_samples/common_widget/app_bar_items.dart';
import 'package:ui_samples/common_widget/carousel.dart';
import 'package:ui_samples/common_widget/toggle_button.dart';
import 'package:ui_samples/constant/ui_const.dart';
import 'package:ui_samples/model/head_light_type.dart';

/// トグルボタン&カルーセルサンプル画面
class ToggleCarouselScreen extends StatelessWidget {
  const ToggleCarouselScreen(this.title);

  final String title;

  static Route<dynamic> route(String title) {
    return MaterialPageRoute(
      builder: (_) => ToggleCarouselScreen(title),
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
                '\nトグルボタンとカルーセルの組み合わせ,',
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
  HeadLightMode _selectedOption = HeadLightMode.auto;
  late PageController _pageViewController;
  bool _isPageViewAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(
      initialPage: _selectedOption.index,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

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
            controller: _pageViewController,
            onPageChanged: (index) {
              if (!_isPageViewAnimating) {
                setState(() {
                  _selectedOption = HeadLightMode.values[index];
                });
              }
            },
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
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: mainHorizontalPadding,
          ),
          child: ToggleButton<HeadLightMode>(
            options: HeadLightMode.values,
            groupValue: _selectedOption,
            onChanged: (value) => setState(() {
              if (value != null) {
                _selectedOption = value;
                _isPageViewAnimating = true;
                _pageViewController
                    .animateToPage(
                      value.index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                    .then((_) => _isPageViewAnimating = false);
              }
            }),
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
