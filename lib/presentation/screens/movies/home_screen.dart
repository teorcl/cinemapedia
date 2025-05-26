import 'package:flutter/material.dart';

import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int viewIndex;
  const HomeScreen({
    super.key,
    required this.viewIndex,
  });

  final List<Widget> _views = const [
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: viewIndex,
        children: _views,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: viewIndex,
      ),
    );
  }
}
