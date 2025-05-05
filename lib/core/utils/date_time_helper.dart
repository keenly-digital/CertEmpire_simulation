class DateTimeHelper {
  // Method to format DateTime to "dd MMM yyyy"
  static String getReadableDate(DateTime dateTime) {
    // List of month abbreviations
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    // Extract day, month, and year
    int day = dateTime.day;
    String month = months[dateTime.month - 1]; // Month index starts from 0
    int year = dateTime.year;

    // Return formatted string
    return "$day $month $year";
  }
}


