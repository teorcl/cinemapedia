import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final StatefulNavigationShell childView;

  const CustomBottomNavigation({
    super.key, 
    required this.childView,
  });

  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: childView.currentIndex,
      onTap: (value) => childView.goBranch(value),
      elevation: 0,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          activeIcon: Icon(Icons.label),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          activeIcon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
