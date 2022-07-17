class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime sendAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.sendAt,
  });
}

List<NotificationItem> notificationsList = [
  NotificationItem(
    id: "1",
    title: "50% off on your saved course",
    message:
        "Lorem ipsum donec quis mi a mauris condimentum elementum. Suspendisse suscipit arcu et mattis tincidunt.",
    sendAt: DateTime.now(),
  ),
  NotificationItem(
    id: "2",
    title: "Couse purchased success",
    message:
        "Design with adobe illustrator cc 2021 - Masterclass course purchase successfully join best of luck for this course.",
    sendAt: DateTime.now(),
  ),
  NotificationItem(
    id: "3",
    title: "Claim Your 20% Discount on  Course",
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididun.",
    sendAt: DateTime.now(),
  ),
  NotificationItem(
    id: "4",
    title: "Claim Your 20% Discount on  Course",
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    sendAt: DateTime.now(),
  ),
  NotificationItem(
    id: "5",
    title: "Claim Your 20% Discount on  Course",
    message:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    sendAt: DateTime.now(),
  ),
];
