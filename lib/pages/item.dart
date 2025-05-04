class Item {
  final String name;
  final String description;
  final String tags;
  final bool isPrivate;

  Item({
    required this.name,
    this.description = '',
    this.tags = '',
    this.isPrivate = true,
  });
}