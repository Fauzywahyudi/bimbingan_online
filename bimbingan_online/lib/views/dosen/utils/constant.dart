import '../icon/custome_icon.dart';
import 'package:flutter/material.dart';

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFFF6F5F8);
const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);
const String imagePath = 'assets/image';

const String devMausam =
    'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fprofile.jpg?alt=media&token=83fa8b83-f53b-489c-a799-ca5d5aceae7b';

const Color furnitureCateDisableColor = Color(0xFF939BA9);
const List lampsImage = [
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fa.jpg?alt=media&token=6af6cfed-84a6-4cf3-a5ce-875fe47f8c5b'
  },
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fb.jpg?alt=media&token=801b2f22-94fd-419b-8b84-c9b4fbd45d4d'
  },
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fc.jpg?alt=media&token=b4470e0b-411f-4925-acaf-d6cb9292a44e'
  },
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fd.jpg?alt=media&token=01ed6f8d-8e1d-403a-a5a0-423b7aa958be'
  },
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fe.jpg?alt=media&token=a9342ee6-9dc6-452d-ade7-4a1d7783e7fe'
  },
  {
    'image':
        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Ff.jpg?alt=media&token=c65c13ad-5b2f-494e-82eb-13d730d823ce'
  },
];
List<ProfileMenu> lampList = [
  ProfileMenu(title: 'Landscape', subTitle: '384'),
  ProfileMenu(title: 'Discus Pendant', subTitle: '274'),
  ProfileMenu(title: 'Mushroom Lamp', subTitle: '374'),
  ProfileMenu(title: 'Titanic Pendant', subTitle: '562'),
  ProfileMenu(title: 'Torn Lighting', subTitle: '105'),
  ProfileMenu(title: 'Abduction Pendant', subTitle: '365'),
];
const List profileItems = [
  {'count': '846', 'name': 'Collect'},
  {'count': '51', 'name': 'Attention'},
  {'count': '267', 'name': 'Track'},
  {'count': '39', 'name': 'Coupons'},
];

List<Catg> listProfileCategories = [
  Catg(name: 'Mahasiswa', icon: Icons.person, number: 0),
  Catg(name: 'Dosen', icon: Icons.person_outline, number: 0),
  Catg(name: 'Proposal', icon: Icons.archive, number: 2),
  Catg(name: 'Jadwal', icon: Icons.schedule, number: 2),
  Catg(name: 'Kompre', icon: Icons.school, number: 0),
];

List<FurnitureCatg> furnitureCategoriesList = [
  FurnitureCatg(icon: Icons.desktop_windows, elivation: true),
  FurnitureCatg(icon: CustomIcon.account_balance_wallet, elivation: false),
  FurnitureCatg(icon: Icons.security, elivation: false),
  FurnitureCatg(icon: CustomIcon.chat, elivation: false),
  FurnitureCatg(icon: CustomIcon.money, elivation: false),
];

List<ProfileMenu> profileMenuList = [
  ProfileMenu(
    title: 'Mahasiswa Bimbingan',
    subTitle: 'Data mahasiswa bimbingan',
    iconColor: profile_info_address,
    icon: Icons.group,
  ),
  ProfileMenu(
    title: 'Daftar Bimbingan',
    subTitle: 'Daftar jadwal bimbingan',
    iconColor: profile_info_privacy,
    icon: Icons.schedule,
  ),
  ProfileMenu(
    title: 'Pesan',
    subTitle: 'Pesan dengan mahasiswa bimbingan',
    iconColor: profile_info_general,
    icon: Icons.message,
  ),
  ProfileMenu(
    title: 'Notifikasi',
    subTitle: 'Notifikasi informasi bimbingan',
    iconColor: profile_info_notification,
    icon: Icons.notifications,
  ),
];

class ProfileMenu {
  String title;
  String subTitle;
  IconData icon;
  Color iconColor;
  ProfileMenu({this.icon, this.title, this.iconColor, this.subTitle});
}

class Catg {
  String name;
  IconData icon;
  int number;
  Catg({this.icon, this.name, this.number});
}

class FurnitureCatg {
  IconData icon;
  bool elivation;
  FurnitureCatg({this.icon, this.elivation});
}
