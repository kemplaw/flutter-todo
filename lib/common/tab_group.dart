import 'package:flutter/material.dart';

enum TabStatus {
  all,
  active,
  completed,
}

class TabGroup extends StatelessWidget {
  TabGroup({this.onPressed});

  void Function(TabStatus id) onPressed;

  Widget _tabItemBuilder(TabStatus id, String label) {
    return FlatButton(
      child: Text(label),
      onPressed: () {
        onPressed(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tabItemBuilder(TabStatus.all, 'all'),
        _tabItemBuilder(TabStatus.active, 'active'),
        _tabItemBuilder(TabStatus.completed, 'completed'),
      ],
    );
  }
}
