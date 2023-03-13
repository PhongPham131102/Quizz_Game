import 'package:flutter/material.dart';
import '../objects/Profile.dart';

String Bg_Rank(Profile index) {
  if (index.rank == "Mầm Non") {
    return "img/bglopmam.png";
  } else if (index.rank == "Cấp 1") {
    return "img/bgcap1.png";
  } else if (index.rank == "Cấp 2") {
    return "img/bgcap2.png";
  } else if (index.rank == "Cấp 3") {
    return "img/bgcap3.png";
  } else if (index.rank == "Trường Đời") {
    return "img/bgtruongdoi.png";
  } else {
    return "img/bglopmam.png";
  }
}
String Icon_Rank(Profile index) {
  if (index.rank == "Mầm Non") {
    return "img/maugiao.png";
  } else if (index.rank == "Cấp 1") {
    return "img/cap1.png";
  } else if (index.rank == "Cấp 2") {
    return "img/cap2.png";
  } else if (index.rank == "Cấp 3") {
    return "img/cap3.png";
  } else if (index.rank == "Trường Đời") {
    return "img/totnghiep.png";
  } else {
    return "img/maugiao.png";
  }
}
String Maxexp(Profile index)
{
   if (index.level == 1) {
    return "100";
  } else if (index.level == 2) {
    return "120";
  }else if (index.level == 3) {
    return "150";
  }else if (index.level == 4) {
    return "190";
  }else if (index.level == 5) {
    return "240";
  }else if (index.level == 6) {
    return "300";
  }else if (index.level == 7) {
    return "370";
  }else if (index.level == 8) {
    return "450";
  }else if (index.level == 9) {
    return "540";
  }else if (index.level == 10) {
    return "640";
  }else if (index.level == 11) {
    return "750";
  }else if (index.level == 12) {
    return "870";
  }else if (index.level == 13) {
    return "1000";
  }else if (index.level == 14) {
    return "1140";
  }else if (index.level == 15) {
    return "1290";
  }else if (index.level == 16) {
    return "1450";
  }else if (index.level == 17) {
    return "1620";
  }else if (index.level == 18) {
    return "1800";
  }else {
    return "2000";
  }
}
int percentexp(Profile index)
{
   if (index.level == 1) {
    return 100;
  } else if (index.level == 2) {
    return 120;
  }else if (index.level == 3) {
    return 150;
  }else if (index.level == 4) {
    return 190;
  }else if (index.level == 5) {
    return 240;
  }else if (index.level == 6) {
    return 300;
  }else if (index.level == 7) {
    return 370;
  }else if (index.level == 8) {
    return 450;
  }else if (index.level == 9) {
    return 540;
  }else if (index.level == 10) {
    return 640;
  }else if (index.level == 11) {
    return 750;
  }else if (index.level == 12) {
    return 870;
  }else if (index.level == 13) {
    return 1000;
  }else if (index.level == 14) {
    return 1140;
  }else if (index.level == 15) {
    return 1290;
  }else if (index.level == 16) {
    return 1450;
  }else if (index.level == 17) {
    return 1620;
  }else if (index.level == 18) {
    return 1800;
  }else {
    return 2000;
  }
}
int exp(Profile profile)
{
  int maxexp=percentexp(profile);
  int nowexp=profile.exp;
  double total=(nowexp/maxexp)*100;
  return total.toInt();
}