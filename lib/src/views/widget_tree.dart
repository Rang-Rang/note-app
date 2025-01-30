import 'package:flutter/material.dart';
import 'package:todo_list/src/views/widgets/drawer_widget.dart';
import '../res/notifier.dart';
import 'pages/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset <= 0) {
      if (!isAtTopHome.value) {
        isAtTopHome.value = true;
        scrollButtonPositionHome.value = Position.top;
        scrollButtonIconHome.value = const Icon(Icons.arrow_downward);
      }
    } else if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (isAtTopHome.value) {
        isAtTopHome.value = false;
        scrollButtonPositionHome.value = Position.bottom;
        scrollButtonIconHome.value = const Icon(Icons.arrow_upward);
      }
    }
  }

  void _scrollToPosition() {
    if (scrollButtonPositionHome.value == Position.bottom) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _scrollToPosition,
            icon: ValueListenableBuilder(
              valueListenable: scrollButtonIconHome,
              builder: (context, icon, child) {
                return icon;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ValueListenableBuilder(
              valueListenable: isListViews,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    isListViews.value = !isListViews.value;
                  },
                  icon: listViews,
                );
              },
            ),
          ),
        ],
      ),
      body: HomePage(
        scrollController: _scrollController,
      ),
    );
  }
}
