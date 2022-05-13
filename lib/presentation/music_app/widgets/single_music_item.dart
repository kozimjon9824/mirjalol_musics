import 'package:flutter/material.dart';

class SingleMusicItem extends StatelessWidget {
  const SingleMusicItem({
    Key? key,
    required this.onTap,
    required this.bgColor,
    required this.title,
    required this.duration,
  }) : super(key: key);

  final Function() onTap;
  final Color bgColor;
  final String title;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: bgColor,
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/profile_pic.png',
                height: 60, width: 60),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Mirjalol Nematov',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    Text(
                      duration,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
