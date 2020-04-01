import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

void toast({msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black45,
      textColor: Colors.white);
}

String genre(List<int> genreIds) {
  String genres = '';
  genreIds.forEach((genreId) {
    switch (genreId) {
      case 12:
        return genres = genres + ' Adventure';
      case 16:
        return genres = genres + ' Animation';
      case 28:
        return genres = genres + ' Action';
      case 35:
        return genres = genres + ' Comedy';
      case 80:
        return genres = genres + ' Crime';
      case 99:
        return genres = genres + ' Documentary';
      case 18:
        return genres = genres + ' Drama';
      case 10751:
        return genres = genres + ' Family';
      case 14:
        return genres = genres + ' Fantasy';
      case 36:
        return genres = genres + ' History';
      case 27:
        return genres = genres + ' Horror';
      case 10402:
        return genres = genres + ' Music';
      case 9648:
        return genres = genres + ' Mystery';
      case 10749:
        return genres = genres + ' Romance';
      case 878:
        return genres = genres + ' Science Fiction';
      case 10770:
        return genres = genres + ' TV Movie';
      case 53:
        return genres = genres + ' Thriller';
      case 10752:
        return genres = genres + ' War';
      case 37:
        return genres = genres + ' Western';
      default:
        return genres = genres + ' Unknown';
    }
  });
  return genres.isNotEmpty ? genres.trim().replaceAll(' ', ' | ') : 'N/A';
}
