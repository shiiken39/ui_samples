import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_samples/common_widget/app_bar_items.dart';
import 'package:ui_samples/common_widget/real_toggle_button.dart';
import 'package:ui_samples/common_widget/toggle_button.dart';
import 'package:ui_samples/constant/ui_const.dart';
import 'package:ui_samples/model/head_light_type.dart';

/// トグルボタンサンプル画面
class ToggleButtonScreen extends StatelessWidget {
  const ToggleButtonScreen(this.title);

  final String title;

  static Route<dynamic> route(String title) {
    return MaterialPageRoute(
      builder: (_) => ToggleButtonScreen(title),
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
                '\n1. タップして変更'
                '\n2. ドラッグして変更',
          ),
        ],
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  HeadLightMode? _selectedOption = HeadLightMode.off;
  bool _isReal = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mainHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoSwitch(
                value: _isReal,
                onChanged: (value) => setState(() {
                  _isReal = value;
                }),
              ),
            ],
          ),
          const Gap(20),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(commonBorderRadius),
              color: secondaryBackgroundColor,
            ),
            child: Text(
              '選択中 : $_selectedOption',
              style: textTheme.titleMedium,
            ),
          ),
          const Divider(height: 80),
          Container(
            height: 100,
            alignment: Alignment.topCenter,
            child: _isReal
                ? RealToggleButton<HeadLightMode>(
                    options: HeadLightMode.values,
                    groupValue: _selectedOption,
                    onChanged: (value) => setState(() {
                      _selectedOption = value;
                    }),
                  )
                : ToggleButton<HeadLightMode>(
                    options: HeadLightMode.values,
                    groupValue: _selectedOption,
                    onChanged: (value) => setState(() {
                      _selectedOption = value;
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}
