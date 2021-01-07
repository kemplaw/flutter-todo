import 'package:flutter/material.dart';

enum TabStatus {
  all,
  active,
  completed,
}

class TabGroup extends StatelessWidget {
  TabGroup({this.checked = TabStatus.all, this.onPressed});

  final TabStatus checked;
  final void Function(TabStatus id) onPressed;

  Widget _tabItemBuilder(BuildContext context, TabStatus id, String label) {
    Color primaryColor = id == checked ? Colors.blue : Colors.black54;

    return RaisedButton(
      color: primaryColor,
      textColor: Colors.white,
      child: Text(label),
      onPressed: () {
        onPressed(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _tabItemBuilder(context, TabStatus.all, 'all'),
        _tabItemBuilder(context, TabStatus.active, 'active'),
        _tabItemBuilder(context, TabStatus.completed, 'completed'),
      ],
    );
  }
}
