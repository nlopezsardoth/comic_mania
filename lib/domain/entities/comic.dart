class Comic {
  final int id;
  final String title;
  final int issueNumber;
  final String? description;
  final int pageCount;
  final String thumbNailPath;
  final List<Creator> creators;

  Comic({
    required this.id,
    required this.title,
    required this.issueNumber,
    this.description,
    required this.pageCount,
    required this.thumbNailPath,
    required this.creators,
  });
}

class Creator {
  final String name;
  final Role role;

  Creator({required this.name, required this.role});
}

enum Role { colorist, editor, inker, letterer, penciler, pencilerCover, writer }
