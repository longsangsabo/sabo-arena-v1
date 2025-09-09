import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation state class để quản lý bottom navigation
class NavigationState {
  final int currentIndex;
  final PageController pageController;

  const NavigationState({
    required this.currentIndex,
    required this.pageController,
  });

  NavigationState copyWith({
    int? currentIndex,
    PageController? pageController,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}

/// Navigation State Notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState(
    currentIndex: 0,
    pageController: PageController(),
  ));

  /// Thay đổi tab hiện tại
  void changeTab(int index) {
    if (index != state.currentIndex) {
      state = state.copyWith(currentIndex: index);
      state.pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Update index từ PageView
  void updateIndex(int index) {
    if (index != state.currentIndex) {
      state = state.copyWith(currentIndex: index);
    }
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

/// Navigation Provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

/// Current tab index provider (shortcut)
final currentTabProvider = Provider<int>((ref) {
  return ref.watch(navigationProvider).currentIndex;
});

/// Page controller provider (shortcut)
final pageControllerProvider = Provider<PageController>((ref) {
  return ref.watch(navigationProvider).pageController;
});
