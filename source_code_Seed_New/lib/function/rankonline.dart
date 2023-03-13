List<String> Uprank(String nowrank, String detailrank) {
  if (nowrank == "Mầm Non") {
    if (detailrank == "Lớp Mầm") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Chòi";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp Chòi") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Lá";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp Lá") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 1";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 1") {
    if (detailrank == "Lớp 1") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 2";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 2") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 3";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 3") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 4";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 4") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 5";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 5") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 6";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 2") {
    if (detailrank == "Lớp 6") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 7";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 7") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 8";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 8") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 9";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 9") {
      String _nowrank = "Cấp 3";
      String _detailrank = "Lớp 10";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 3") {
    if (detailrank == "Lớp 10") {
      String _nowrank = "Cấp 3";
      String _detailrank = "Lớp 11";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 11") {
      String _nowrank = "Cấp 3";
      String _detailrank = "Lớp 12";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 12") {
      String _nowrank = "Trường Đời";
      String _detailrank = "1";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  }
  String _nowrank = "Trường Đời";
  int up = int.parse(detailrank);
  ++up;
  String _detailrank = up.toString();
  var rank = [_nowrank, _detailrank];
  return rank;
}

List<String> Downrank(String nowrank, String detailrank) {
  if (nowrank == "Mầm Non") {
    if (detailrank == "Lớp Mầm") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Mầm";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp Chòi") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Mầm";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp Lá") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Chòi";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 1") {
    if (detailrank == "Lớp 1") {
      String _nowrank = "Mầm Non";
      String _detailrank = "Lớp Lá";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 2") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 1";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 3") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 2";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 4") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 3";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 5") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 4";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 2") {
    if (detailrank == "Lớp 6") {
      String _nowrank = "Cấp 1";
      String _detailrank = "Lớp 5";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 7") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 6";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 8") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 7";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 9") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 8";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  } else if (nowrank == "Cấp 3") {
    if (detailrank == "Lớp 10") {
      String _nowrank = "Cấp 2";
      String _detailrank = "Lớp 9";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 11") {
      String _nowrank = "Cấp 3";
      String _detailrank = "Lớp 10";
      var rank = [_nowrank, _detailrank];
      return rank;
    } else if (detailrank == "Lớp 12") {
      String _nowrank = "Cấp 3";
      String _detailrank = "Lớp 11";
      var rank = [_nowrank, _detailrank];
      return rank;
    }
  }
  String _nowrank = "Trường Đời";
  String _detailrank;
  int up = int.parse(detailrank);
  if (up == 1) {
    _nowrank = "Cấp 3";
    _detailrank = "Lớp 12";
  } else {
    --up;
    _detailrank = up.toString();
  }
  var rank = [_nowrank, _detailrank];
  return rank;
}
