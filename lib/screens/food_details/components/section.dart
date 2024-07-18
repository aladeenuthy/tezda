import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Section extends StatelessWidget {
  final String title;
  final String body;
  const Section({
    Key? key,
    required this.title,
    required this.body
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children:  [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(body,
            style: const TextStyle(
                fontSize: 16, color: greyColor, fontWeight: FontWeight.bold))
      ]),
    );
  }
}
