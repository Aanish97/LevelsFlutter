import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/Screens/edit_profile.dart';
import 'package:levels_athletes_coaches/Screens/home_screen.dart';
import 'package:levels_athletes_coaches/Screens/profile_screen.dart';
import 'package:levels_athletes_coaches/Screens/search_screen.dart';

class TabContainer extends StatefulWidget {
  const TabContainer({super.key});

  @override
  TabContainerState createState() => TabContainerState();
}

class TabContainerState extends State<TabContainer> {
  late List<Widget> originalList;
  late Map<int, bool> originalDic;
  late List<Widget> listScreens;
  late List<int> listScreensIndex;

  int tabIndex = 0;
  Color tabColor = const Color(0xff94959b);
  Color selectedTabColor = Colors.black;

  @override
  void initState() {
    super.initState();

    originalList = [
      const HomeScreen(),
      const EditProfile(),
      const SearchScreen(),
      const ProfileScreen(),
    ];
    originalDic = {
      0: true,
      1: false,
      2: false,
      3: false,
    };
    listScreens = [originalList.first];
    listScreensIndex = [0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: listScreensIndex.indexOf(tabIndex), children: listScreens),
      bottomNavigationBar: _buildTabBar(),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _selectedTab(int index) {
    if (originalDic[index] == false) {
      listScreensIndex.add(index);
      originalDic[index] = true;
      listScreensIndex.sort();
      listScreens = listScreensIndex.map((index) {
        return originalList[index];
      }).toList();
    }

    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(iconData: Icons.home),
      BottomAppBarItem(iconData: Icons.person),
      BottomAppBarItem(iconData: Icons.search),
      BottomAppBarItem(iconData: Icons.settings),
    ];

    var items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
      );
    });

    return BottomAppBar(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    var color = tabIndex == index ? selectedTabColor : tabColor;
    return GestureDetector(
      onTap: () => onPressed(index),
      child: SizedBox(
          width: 50, child: Icon(item.iconData, color: color, size: 30)),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({required this.iconData});

  IconData iconData;
}
