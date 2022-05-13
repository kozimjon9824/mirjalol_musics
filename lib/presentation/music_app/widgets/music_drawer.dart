import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/app_colors.dart';

class MusicDrawer extends StatelessWidget {
  const MusicDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/mirjalol.jpeg')),
            accountEmail: const Text('Qo\'shiqlar to\'plami.'),
            accountName: const Text(
              'Mirjalol Nematov',
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: const BoxDecoration(
              color: AppColors.neutral,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'M.Nematov ijtimoiy tarmoqlarda',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_telegram.svg',
                height: 30, width: 30),
            title: const Text(
              'Telegram',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _launchUrl('https://t.me/mirjalol_nematov');
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_instagram.svg',
                height: 30, width: 30),
            title: const Text(
              'Instagram',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _launchUrl('https://www.instagram.com/mirjalol_nematov_/');
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_youtube.svg',
                color: AppColors.fioletivy, height: 30, width: 30),
            title: const Text(
              'Youtube',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () async {
              var url = 'https://www.youtube.com/c/MirjalolNematov/videos';
              if (!await launchUrl(
                Uri.parse(url),
              )) throw 'Could not launch $url';
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_phone.svg',
                height: 30, width: 30),
            title: const Text(
              'Adminstrator',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _launchUrl('tel:+998958079777');
            },
          ),
          const Divider(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 4, bottom: 8),
            child: Text(
              'Takliflar uchun',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_instagram.svg',
                height: 30, width: 30),
            title: const Text(
              'Instagram',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _launchUrl('https://www.instagram.com/kozimjon_khh/');
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/ic_telegram.svg',
                height: 30, width: 30),
            title: const Text(
              'Telegram',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              _launchUrl('https://t.me/kozimjon_kh');
            },
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text('developed by Kozimjon Kh',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }
}
