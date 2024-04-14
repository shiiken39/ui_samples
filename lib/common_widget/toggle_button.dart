import 'package:flutter/material.dart';
import 'package:ui_samples/constant/ui_const.dart';

/// トグルボタン
class ToggleButton<T> extends StatelessWidget {
  const ToggleButton({
    required this.options,
    required this.groupValue,
    required this.onChanged,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = const BorderRadius.all(Radius.circular(25)),
    this.duration = const Duration(milliseconds: 300),
  });

  /// 選択肢のリスト
  final List<T> options;

  /// 選択中の値
  final T? groupValue;

  /// 選択肢が変更されたときのコールバック
  final ValueChanged<T?>? onChanged;

  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: secondaryBackgroundColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth =
              width == double.infinity ? constraints.maxWidth : width;
          final elementWidth = availableWidth / options.length;

          return _Content<T>(
            options: options,
            groupValue: groupValue,
            onChanged: onChanged,
            elementWidth: elementWidth,
            height: height,
            borderRadius: borderRadius,
            duration: duration,
          );
        },
      ),
    );
  }
}

class _Content<T> extends StatefulWidget {
  const _Content({
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.elementWidth,
    required this.height,
    required this.borderRadius,
    required this.duration,
  });

  final List<T> options;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final double elementWidth;
  final double height;
  final BorderRadius borderRadius;
  final Duration duration;

  @override
  State<_Content<T>> createState() => __ContentState<T>();
}

class __ContentState<T> extends State<_Content<T>> {
  double _dragStartX = 0;
  double _dragOffsetX = 0;
  int? _isDraggingToIndex;

  void _onDragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
  }

  void _onDragUpdate(DragUpdateDetails details, double elementWidth) {
    final dragOffsetX = details.localPosition.dx - _dragStartX;

    final currentIndex = widget.options.indexOf(widget.groupValue as T);
    final isAtFirst = currentIndex == 0;
    final isAtLast = currentIndex == widget.options.length - 1;
    final dragLeft = dragOffsetX < 0;
    final dragRight = dragOffsetX > 0;

    // 選択中の要素が端にある場合はそれ以上のドラッグを無視
    if ((isAtFirst && dragLeft) || (isAtLast && dragRight)) {
      return;
    }

    setState(() {
      _dragOffsetX = dragOffsetX;

      // 隣の要素に移動した場合
      if (dragOffsetX.abs() > elementWidth) {
        final newIndex = currentIndex + (dragOffsetX > 0 ? 1 : -1);
        widget.onChanged?.call(widget.options[newIndex]);
        _dragStartX = details.localPosition.dx;
        _dragOffsetX = 0;
        _isDraggingToIndex = null;
      }

      // ある程度隣の要素に移動している場合
      else if (dragOffsetX.abs() > (elementWidth * 0.5)) {
        // 選択中のTextColorを変更するために、_isDraggingToIndexをセット
        _isDraggingToIndex = currentIndex + (dragOffsetX > 0 ? 1 : -1);
      }

      // それ以外
      else {
        _isDraggingToIndex = null;
      }
    });
  }

  void _onDragEnd(DragEndDetails details, double elementWidth) {
    setState(() {
      // ドラッグ終了時、ある程度隣の要素に移動していた場合は移動させる
      if (_dragOffsetX.abs() > (elementWidth * 0.5)) {
        final currentIndex = widget.options.indexOf(widget.groupValue as T);
        final newIndex = currentIndex + (_dragOffsetX > 0 ? 1 : -1);
        widget.onChanged?.call(widget.options[newIndex]);
      }
      // リセット
      _dragOffsetX = 0;
      _dragStartX = 0;
      _isDraggingToIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.options.indexOf(widget.groupValue as T);
    final left = currentIndex * widget.elementWidth + _dragOffsetX;
    return Stack(
      children: [
        // 選択中の要素の背景
        AnimatedPositioned(
          duration: _dragStartX == 0 ? widget.duration : Duration.zero,
          curve: Curves.easeInOut,
          left: left,
          child: Container(
            width: widget.elementWidth,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: primaryColor,
            ),
          ),
        ),
        // 各選択肢
        Row(
          children: widget.options.map((option) {
            return GestureDetector(
              onTap: () => widget.onChanged?.call(option),
              child: Container(
                width: widget.elementWidth,
                height: widget.height,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: AnimatedDefaultTextStyle(
                  duration: widget.duration,
                  style: TextStyle(
                    color: _isDraggingToIndex == null
                        ? option == widget.groupValue
                            ? Colors.white
                            : primaryTextColor
                        : option == widget.options[_isDraggingToIndex!]
                            ? Colors.white
                            : primaryTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text(option.toString()),
                ),
              ),
            );
          }).toList(),
        ),
        // ドラッグ用の透明なコンテナ
        Positioned(
          left: left,
          child: GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: (details) =>
                _onDragUpdate(details, widget.elementWidth),
            onHorizontalDragEnd: (details) =>
                _onDragEnd(details, widget.elementWidth),
            child: Container(
              width: widget.elementWidth,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
