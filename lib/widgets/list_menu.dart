import 'package:flutter/material.dart';

import '../utils/device.dart';
import 'widgets.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({
    Key? key,
    required this.onAddNewPress,
  }) : super(key: key);

  final void Function() onAddNewPress;

  final IconData addIcon = Icons.add;
  final IconData filterIcon = Icons.filter_list;

  @override
  Widget build(BuildContext context) {
    if (Device.of(context).deviceType == DeviceType.phone) {
      return _ListMenuLarge(
        addIcon: addIcon,
        filterIcon: filterIcon,
        onAddNewPress: onAddNewPress,
      );
    } else {
      return _ListMenuSmall(
        addIcon: addIcon,
        filterIcon: filterIcon,
        onAddNewPress: onAddNewPress,
      );
    }
  }
}

class _ListMenuSmall extends StatelessWidget {
  const _ListMenuSmall({
    Key? key,
    required this.addIcon,
    required this.filterIcon,
    required this.onAddNewPress,
  }) : super(key: key);

  final IconData addIcon;
  final IconData filterIcon;

  final void Function() onAddNewPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onAddNewPress,
          child: Row(
            children: [Text('Add New'), Icon(addIcon)],
          ),
        ),
        const SizedBox(width: 4),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [Text('Filters'), Icon(filterIcon)],
          ),
        ),
      ],
    );
  }
}

class _ListMenuLarge extends StatelessWidget {
  const _ListMenuLarge({
    Key? key,
    required this.addIcon,
    required this.filterIcon,
    required this.onAddNewPress,
  }) : super(key: key);

  final IconData addIcon;
  final IconData filterIcon;

  final void Function() onAddNewPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleButton(
              iconColor: Colors.white,
              filledColor: Colors.green,
              borderColor: Colors.transparent,
              iconData: addIcon,
              onTap: onAddNewPress,
            ),
            const SizedBox(width: 4),
            CircleButton(
              iconColor: Colors.white,
              filledColor: Colors.grey,
              borderColor: Colors.transparent,
              iconData: filterIcon,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
