import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'main_contanainer_bloc.dart';

class MainContanainerDart extends StatefulWidget {
  const MainContanainerDart({Key? key}) : super(key: key);

  @override
  State<MainContanainerDart> createState() => _MainContanainerDartState();
}

class _MainContanainerDartState extends State<MainContanainerDart> {
  final _bloc = MainContanainerBloc();

  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("===b " + value!);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<int>(
            valueListenable: _bloc.currentTabIndexNotifier,
            builder: (context, data, child) {
              return IndexedStack(
                index: data,
                children: _bloc.navTabs,
              );
            }),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        //  controller: controller,
        backgroundColor: Colors.pink,
        top: -20,
        height: 55,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
          TabItem(icon: Icons.notification_add, title: 'notification'),
        ],
        initialActiveIndex: 0,
        onTap: ((index) => _bloc.currentTabIndexNotifier.value = index),
      ),
    );
  }
}
