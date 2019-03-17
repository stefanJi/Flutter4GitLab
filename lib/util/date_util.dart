DateTime string2Datetime(String date) {
  return DateTime.parse(date).toLocal();
}

String datetime2String(DateTime datetime) {
  return "${datetime.year}/${datetime.month}/${datetime.day} ${datetime.hour}:${datetime.minute}:${datetime.second}";
}
