import 'package:flutter/material.dart';

/// カード型画面
class CardSampleScreen extends StatelessWidget {
  const CardSampleScreen({
    this.backgroundCardController,
  });

  final AnimationController? backgroundCardController;

  static Route<dynamic> route([AnimationController? backgroundController]) {
    return TransparentRoute(
      builder: (_) => CardSampleScreen(
        backgroundCardController: backgroundController,
      ),
    );
  }

  static Future<void> push(
    BuildContext context, [
    AnimationController? backgroundController,
  ]) async {
    await Navigator.push(context, route(backgroundController));
  }

  @override
  Widget build(BuildContext context) {
    return CardScreen<dynamic>(
      backgroundCardController: backgroundCardController,
      contentBuilder: (ownBackgroundController, close) {
        return _Body(
          ownBackgroundController,
          close,
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(
    this.ownBackgroundController,
    this.close,
  );

  final AnimationController ownBackgroundController;
  final VoidCallback? close;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => CardSampleScreen.push(
                context,
                ownBackgroundController,
              ),
              child: const Text('push'),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: close,
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

typedef CardContentBuilder<T> = Widget Function(
  AnimationController ownBackgroundController,
  VoidCallback? close,
);

class TransparentRoute extends PageRouteBuilder<dynamic> {
  TransparentRoute({
    required this.builder,
    super.settings,
  }) : super(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          pageBuilder: (BuildContext context, _, __) {
            return builder(context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );

  final WidgetBuilder builder;
}

class CardScreen<T> extends StatefulWidget {
  const CardScreen({
    this.backgroundCardController,
    required this.contentBuilder,
  });

  /// このモーダルの一つ前(後ろ)のコントローラー
  final AnimationController? backgroundCardController;

  final CardContentBuilder<T> contentBuilder;

  @override
  State<CardScreen<T>> createState() => _CardScreenState<T>();
}

class _CardScreenState<T> extends State<CardScreen<T>>
    with TickerProviderStateMixin {
  /// メインのコントローラー
  late AnimationController controller;

  /// このカードの上に新しいカードした時に使用
  /// 新しいカードの動きに合わせてこのカードをアニメーションさせる
  late AnimationController ownBackgroundController;

  /// 現在のRouteの高さ
  late double screenHeight;

  /// アニメーション時間(ms)
  final duration = 200;

  /// 中央より少しだけ下にずらす
  /// 中央に配置しても、ボトムナビゲーションバーがあるため上よりになっている！
  final btmShift = 20;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );
    ownBackgroundController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );

    widget.backgroundCardController?.forward();
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    ownBackgroundController.dispose();
  }

  void close({bool pop = true}) {
    widget.backgroundCardController?.reverse();
    controller.duration = Duration(milliseconds: duration);
    controller.reverse().then((value) {
      if (pop) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenHeight = constraints.maxHeight;

        return AnimatedBuilder(
          animation: Listenable.merge([
            controller,
            widget.backgroundCardController,
          ]),
          child: CardContent<T>(
            screenHeight: screenHeight,
            controller: controller,
            ownBackgroundController: ownBackgroundController,
            backgroundCardController: widget.backgroundCardController,
            close: close,
            contentBuilder: widget.contentBuilder,
          ),
          builder: (context, child) {
            var backgroundColorRate = controller.value;

            if (widget.backgroundCardController != null &&
                widget.backgroundCardController!.value < controller.value) {
              backgroundColorRate = widget.backgroundCardController!.value;
            }

            return Stack(
              children: [
                GestureDetector(
                  onTap: close,
                  child: Container(
                    color: Colors.black.withOpacity(0.40 * backgroundColorRate),
                  ),
                ),
                Center(
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      (1 - controller.value) * screenHeight + btmShift,
                    ),
                    child: child,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CardContent<T> extends StatefulWidget {
  const CardContent({
    required this.screenHeight,
    required this.controller,
    required this.ownBackgroundController,
    required this.backgroundCardController,
    required this.close,
    required this.contentBuilder,
  });

  final double screenHeight;
  final AnimationController controller;
  final AnimationController ownBackgroundController;
  final AnimationController? backgroundCardController;
  final void Function({bool pop}) close;
  final CardContentBuilder<T> contentBuilder;

  @override
  State<CardContent<T>> createState() => _CardContentState<T>();
}

class _CardContentState<T> extends State<CardContent<T>>
    with TickerProviderStateMixin {
  late double dragStart;
  late double totalDrag;

  /// カード高さ割合（現在のRouteの高さから）
  final heightRate = 0.7;

  /// カード横幅割合（現在のRouteの横幅から）
  final widthRate = 0.8;

  /// アニメーション時間(ms)
  final duration = 200;

  /// バックグランドになった時に上に動く距離
  final backgroundDistance = 80;

  /// バックグランド時のスケール
  final backgroundScale = 0.15;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        dragStart = event.position.dy;
        totalDrag = 0;
      },
      onPointerMove: (PointerMoveEvent event) {
        totalDrag += event.delta.dy;
        widget.controller.value = 1 - (totalDrag / widget.screenHeight);
        widget.backgroundCardController?.value =
            1 - (totalDrag / backgroundDistance);
      },
      onPointerUp: (PointerUpEvent event) {
        final dragDistance = totalDrag / widget.screenHeight;

        if (dragDistance < 0.10) {
          widget.backgroundCardController?.forward();

          // 一時的にアニメーションの速度をゆっくりにする
          widget.controller.duration = const Duration(milliseconds: 2500);
          widget.controller.forward().then((_) {
            // 元の速度に戻す
            widget.controller.duration = Duration(milliseconds: duration);
          });
        } else {
          widget.close.call();
        }
      },
      child: AnimatedBuilder(
        animation: widget.ownBackgroundController,
        builder: (BuildContext context, Widget? child) {
          return Transform(
            // Transform.translateとTransform.scaleの合わせて使うのと同じ
            alignment: Alignment.center,
            transform: Matrix4.translationValues(
              0,
              widget.ownBackgroundController.value * -backgroundDistance,
              0,
            )..scale(
                1 - (widget.ownBackgroundController.value * backgroundScale),
              ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight * heightRate;
                final width = constraints.maxWidth * widthRate;

                return Material(
                  borderRadius: BorderRadius.circular(30),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: PopScope(
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        widget.close(pop: false);
                      }
                    },
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: widget.contentBuilder(
                        widget.ownBackgroundController,
                        widget.close,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
