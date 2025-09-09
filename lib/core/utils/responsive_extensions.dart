/// Responsive extensions for sizing
extension ResponsiveExtensions on num {
  /// Vertical spacing
  double get v => toDouble();
  
  /// Horizontal spacing  
  double get h => toDouble();
  
  /// Adaptive size for both width and height
  double get adaptSize => toDouble();
  
  /// Font size scaling
  double get fSize => toDouble();
}
