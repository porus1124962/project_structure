import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_view.dart';

/// Bottom bar with 4 tabs. Use when you need tab-based navigation.
class BottomBarView extends StatefulWidget {
  const BottomBarView({this.initialIndex = 0, super.key});

  final int initialIndex;

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final RxInt _selectedPagesIndex = 0.obs;
  bool? hasInternet;

  final _pageOptions = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];

  void checkConnectivity() {
    try {
      Connectivity().onConnectivityChanged.listen((result) {
        final results = result is List ? result as List<ConnectivityResult> : [result as ConnectivityResult];
        final connected = results.any((r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile);
        if (mounted) setState(() => hasInternet = connected);
      });
    } catch (e) {
      if (mounted) setState(() => hasInternet = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedPagesIndex.value = widget.initialIndex;
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: hasInternet == false ? _buildNoInternet(h) : Obx(() => _pageOptions[_selectedPagesIndex.value]),
        bottomNavigationBar: SizedBox(
          height: Platform.isIOS ? h * .12 : kToolbarHeight * 1.2,
          child: _bottomAppBar(),
        ),
      ),
    );
  }

  Widget _buildNoInternet(double h) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/navbar/icon_home.png"), fit: BoxFit.fill),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Oops! No internet connection",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: h * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "It looks like you're offline. Check your connection and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: h * .04),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                onPressed: () => setState(() {}),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: Text("Retry", style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBar() {
    return Obx(() => BottomAppBar(
          color: Colors.white,
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.message, 'Messages'),
              _buildNavItem(2, Icons.person, 'Profile'),
              _buildNavItem(3, Icons.settings, 'Settings'),
            ],
          ),
        ));
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedPagesIndex.value == index;
    return GestureDetector(
      onTap: () => _selectedPagesIndex.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.transparent,
            ),
            child: Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 28),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
