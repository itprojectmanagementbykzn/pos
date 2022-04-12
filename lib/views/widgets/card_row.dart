import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class CardRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final void Function()? navigateRoute;
  const CardRow({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    required this.navigateRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateRoute,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //Icon
              Icon(icon, size: 50, color: color),
              const SizedBox(
                width: 15,
              ),
              //Text
              SizedBox(
                width: 80,
                child: Text(text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: buttonText.copyWith(
                      color: color,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
