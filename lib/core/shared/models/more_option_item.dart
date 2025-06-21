class MoreOptionItem {
  String title;
  String iconPath;
  MobileMoreOptionViewType actionType;

  MoreOptionItem(
      {required this.title, required this.iconPath, required this.actionType});
}

enum MobileMoreOptionViewType { primary ,profile, changePassword, subscription, createFile }
