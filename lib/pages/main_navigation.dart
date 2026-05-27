// lib/pages/main_navigation.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'quiz_page.dart';
import 'gallery_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    QuizPage(),
    GalleryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textLight,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          elevation: 0,
          items: [
            _navItem(Icons.home_rounded, Icons.home_outlined, 'Home'),
            _navItem(Icons.explore_rounded, Icons.explore_outlined, 'Jelajahi'),
            _navItem(Icons.quiz_rounded, Icons.quiz_outlined, 'Kuis'),
            _navItem(Icons.photo_library_rounded, Icons.photo_library_outlined, 'Galeri'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      IconData activeIcon, IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}