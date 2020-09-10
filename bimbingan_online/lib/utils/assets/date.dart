String bulan(int value) {
  switch (value) {
    case 1:
      return "Jan";
      break;
    case 2:
      return "Feb";
      break;
    case 3:
      return "Mar";
      break;
    case 4:
      return "Apr";
      break;
    case 5:
      return "Mei";
      break;
    case 6:
      return "Jun";
      break;
    case 7:
      return "Jul";
      break;
    case 8:
      return "Agus";
      break;
    case 9:
      return "Sep";
      break;
    case 10:
      return "Okt";
      break;
    case 11:
      return "Nov";
      break;
    case 12:
      return "Des";
      break;
    default:
      return "tidak valid";
      break;
  }
}

String formatTanggal(String value) {
  DateTime date = DateTime.parse(value);
  String result = date.day.toString() +
      " " +
      bulan(date.month) +
      " " +
      date.year.toString();
  return result;
}

String formatJam(String value) {
  DateTime date = DateTime.parse(value);
  String menit = date.minute < 10 ? "0" + date.minute.toString() : date.minute;
  String result = date.hour.toString() + ":" + menit;
  return result;
}
