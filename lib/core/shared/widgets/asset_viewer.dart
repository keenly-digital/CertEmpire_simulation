import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetViewer extends StatelessWidget {
  final String? assetPath; // Path to the asset (local or network)
  final IconData? iconData; // IconData for displaying icons
  final Size size; // Dynamic size based on predefined categories
  final BoxFit fit; // How the asset should fit within the space
  final Widget? placeholder; // Placeholder widget if the asset is loading
  final Widget? errorWidget; // Widget to show if asset loading fails
  final Color? color; // Optional color tint (for SVGs or icons)

  const AssetViewer({
    super.key,
    this.assetPath,
    this.iconData,
    required this.size,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      // Handle IconData
      return _buildIcon();
    } else if (assetPath != null) {
      if (assetPath!.toLowerCase().endsWith('.svg')) {
        // Handle SVG assets
        return _buildSvg();
      } else if (_isImageFormat(assetPath!)) {
        // Handle Image assets
        return _buildImage();
      } else {
        // Unsupported format
        return _buildErrorWidget();
      }
    } else {
      // No asset provided
      return _buildErrorWidget();
    }
  }

  Widget _buildIcon() {
    return Icon(
      iconData,
      size: size.width,
      color: color ?? Colors.black,
    );
  }

  Widget _buildSvg() {
    return SvgPicture.asset(
      assetPath!,
      width: size.width,
      height: size.height,
      fit: fit,
      color: color,
      placeholderBuilder: (context) => placeholder ?? _defaultPlaceholder(),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      assetPath!,
      width: size.width,
      height: size.height,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildErrorWidget();
      },
    );
  }

  // Check for supported image formats
  bool _isImageFormat(String path) {
    final lowerPath = path.toLowerCase();
    return lowerPath.endsWith('.png') ||
        lowerPath.endsWith('.jpg') ||
        lowerPath.endsWith('.jpeg') ||
        lowerPath.endsWith('.gif');
  }

  Widget _defaultPlaceholder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        Center(
          child: Icon(
            Icons.error,
            size: size.width / 2,
            color: Colors.red,
          ),
        );
  }
}
