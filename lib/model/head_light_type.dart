enum HeadLightMode {
  off,
  auto,
  low,
  high;

  @override
  String toString() => name.toUpperCase();

  String get placeholderImage {
    switch (this) {
      case HeadLightMode.off:
        return 'https://placehold.jp/150x150.png?text=OFF';
      case HeadLightMode.auto:
        return 'https://placehold.jp/150x150.png?text=AUTO';
      case HeadLightMode.low:
        return 'https://placehold.jp/150x150.png?text=LOW';
      case HeadLightMode.high:
        return 'https://placehold.jp/150x150.png?text=HIGH';
    }
  }
}
