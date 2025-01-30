import 'package:flutter/material.dart';
import '../../res/notifier.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({
    super.key,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
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

  void _changeAvatarColor() {
    // Select color list based on current theme (dark or light)
    final currentColorList =
        isDarkNotifier.value ? darkModeColors : lightModeColors;

    // Increment the index, and wrap it around if it exceeds the list length
    int newIndex =
        (avatarColorIndexNotifier.value + 1) % currentColorList.length;

    // Update the color index
    avatarColorIndexNotifier.value = newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: isPin,
                        builder: (context, value, child) {
                          return IconButton(
                            onPressed: () {
                              isPin.value = !isPin.value;
                            },
                            icon: pin,
                          );
                        },
                      ),
                      IconButton(
                        onPressed: _scrollToPosition,
                        icon: ValueListenableBuilder(
                          valueListenable: scrollButtonIcon,
                          builder: (context, icon, child) {
                            return icon;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _changeAvatarColor,
                        icon: ValueListenableBuilder<int>(
                          valueListenable: avatarColorIndexNotifier,
                          builder: (context, index, child) {
                            final currentColorList = isDarkNotifier.value
                                ? darkModeColors
                                : lightModeColors;

                            Color avatarColor = currentColorList[index];

                            return CircleAvatar(
                              radius: 10,
                              backgroundColor: avatarColor,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      maxLines: null,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                    ),
                    TextFormField(
                      controller: _noteController,
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
          );
        },
      ),
    );
  }
}
