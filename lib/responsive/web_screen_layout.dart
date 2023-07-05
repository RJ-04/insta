import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: webBackgroundColor,
        centerTitle: true,
        title: SvgPicture.asset(
          'assests/ic_instagram.svg',
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcATop),
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            color: _page == 0 ? primaryColor : secondaryColor,
            icon: const Icon(Icons.home_outlined),
          ),
          IconButton(
            onPressed: () => navigationTapped(1),
            color: _page == 1 ? primaryColor : secondaryColor,
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () => navigationTapped(2),
            color: _page == 2 ? primaryColor : secondaryColor,
            icon: const Icon(Icons.add_a_photo_outlined),
          ),
          /* IconButton(
            onPressed: () => navigationTapped(3),
            color: _page == 3 ? primaryColor : secondaryColor,
            icon: const Icon(Icons.favorite_border_outlined),
          ), */
          IconButton(
            onPressed: () => navigationTapped(3),
            color: _page == 3 ? primaryColor : secondaryColor,
            icon: const Icon(Icons.person_2_outlined),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItmes,
      ),
    );
  }
}
