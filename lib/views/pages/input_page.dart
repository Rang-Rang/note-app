import 'package:flutter/material.dart';

import '../../data/notifier.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final ScrollController _scrollController = ScrollController();
  bool isMenuOpen = false;

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
      if (!isAtTop.value) {
        isAtTop.value = true;
        scrollButtonPosition.value = Position.top;
        scrollButtonIcon.value = Icon(Icons.arrow_downward);
      }
    } else if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (isAtTop.value) {
        isAtTop.value = false;
        scrollButtonPosition.value = Position.bottom;
        scrollButtonIcon.value = Icon(Icons.arrow_upward);
      }
    }
  }

  void _scrollToPosition() {
    if (scrollButtonPosition.value == Position.top) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  Future<bool> _onPop() async {
    if (isMenuOpen) {
      setState(() {
        isMenuOpen = false;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: _onPop,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      isPin.value = !isPin.value;
                    },
                    icon: ValueListenableBuilder(
                      valueListenable: isPin,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return pin;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      isRed.value = !isRed.value;
                    },
                    icon: ValueListenableBuilder(
                      valueListenable: isRed,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 10,
                        );
                      },
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      TextField(
                        maxLines: null,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Note',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  if (isMenuOpen) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 55.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          // Action for other floating buttons
                        },
                        mini: true,
                        child: Icon(Icons.abc),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: FloatingActionButton(
                        onPressed: _scrollToPosition,
                        mini: true,
                        child: ValueListenableBuilder(
                          valueListenable: scrollButtonIcon,
                          builder: (context, icon, child) {
                            return icon;
                          },
                        ),
                      ),
                    ),
                  ],
                  FloatingActionButton(
                    onPressed: _toggleMenu,
                    mini: true,
                    child: Icon(isMenuOpen ? Icons.close : Icons.more_vert),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            ),
          );
        },
      ),
    );
  }
}
