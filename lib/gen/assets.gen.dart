// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/cat_loading.gif
  AssetGenImage get catLoading =>
      const AssetGenImage('assets/animations/cat_loading.gif');

  /// File path: assets/animations/maoew.gif
  AssetGenImage get maoew => const AssetGenImage('assets/animations/maoew.gif');

  /// File path: assets/animations/welcome.gif
  AssetGenImage get welcome =>
      const AssetGenImage('assets/animations/welcome.gif');

  /// List of all assets
  List<AssetGenImage> get values => [catLoading, maoew, welcome];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/app_icon
  $AssetsIconsAppIconGen get appIcon => const $AssetsIconsAppIconGen();

  /// Directory path: assets/icons/bottom_app_bar
  $AssetsIconsBottomAppBarGen get bottomAppBar =>
      const $AssetsIconsBottomAppBarGen();

  /// Directory path: assets/icons/login_and_register
  $AssetsIconsLoginAndRegisterGen get loginAndRegister =>
      const $AssetsIconsLoginAndRegisterGen();
}

class $AssetsIconsAppIconGen {
  const $AssetsIconsAppIconGen();

  /// File path: assets/icons/app_icon/love_you.png
  AssetGenImage get loveYou =>
      const AssetGenImage('assets/icons/app_icon/love_you.png');

  /// List of all assets
  List<AssetGenImage> get values => [loveYou];
}

class $AssetsIconsBottomAppBarGen {
  const $AssetsIconsBottomAppBarGen();

  /// File path: assets/icons/bottom_app_bar/calculator.png
  AssetGenImage get calculator =>
      const AssetGenImage('assets/icons/bottom_app_bar/calculator.png');

  /// File path: assets/icons/bottom_app_bar/listening.png
  AssetGenImage get listening =>
      const AssetGenImage('assets/icons/bottom_app_bar/listening.png');

  /// File path: assets/icons/bottom_app_bar/reading.png
  AssetGenImage get reading =>
      const AssetGenImage('assets/icons/bottom_app_bar/reading.png');

  /// File path: assets/icons/bottom_app_bar/speaking.png
  AssetGenImage get speaking =>
      const AssetGenImage('assets/icons/bottom_app_bar/speaking.png');

  /// File path: assets/icons/bottom_app_bar/writing.png
  AssetGenImage get writing =>
      const AssetGenImage('assets/icons/bottom_app_bar/writing.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    calculator,
    listening,
    reading,
    speaking,
    writing,
  ];
}

class $AssetsIconsLoginAndRegisterGen {
  const $AssetsIconsLoginAndRegisterGen();

  /// File path: assets/icons/login_and_register/apple-logo.png
  AssetGenImage get appleLogo =>
      const AssetGenImage('assets/icons/login_and_register/apple-logo.png');

  /// File path: assets/icons/login_and_register/google-logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/icons/login_and_register/google-logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [appleLogo, googleLogo];
}

class Assets {
  const Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
