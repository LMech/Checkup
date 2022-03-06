import 'package:checkup/core/const/color_constants.dart';
import 'package:checkup/core/const/text_constants.dart';
import 'package:checkup/screens/firends/firends.dart';
import 'package:checkup/screens/home/page/home_page.dart';
import 'package:checkup/screens/settings/settings.dart';
import 'package:checkup/screens/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: ColorConstants.primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: TextConstants.homeIcon,
        ),
        BottomNavigationBarItem(
          label: TextConstants.friendsIcon,
          icon: Icon(Icons.group),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: TextConstants.settingsIcon,
        ),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      const HomePage(),
      const FriendsPage(),
      const SettingsPage()
    ];
    return children[index];
  }
}
