part of flutter_mentions;

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  TextStyle mentionStyle;
  List<Map<String, dynamic>> taggedUsers = [];
  String? _pattern;

  String? outputText;

  var mentionIds = <dynamic>[];

  AnnotationEditingController(this.mentionStyle);

  Function(Map<String, dynamic> value)? _addMentionCallback;

  void registerAddMentionCallback(
      Function(Map<String, dynamic> value) callback) {
    _addMentionCallback = callback;
  }

  void addMention(Map<String, dynamic> value) {
    _addMentionCallback?.call(value);
  }

  void processAddMention(
      Map<String, dynamic> taggedUser, int startPos, String searchText) {
    final user = taggedUser.map((key, value) => MapEntry(key, value));
    user['start'] = startPos;
    taggedUsers.add(user);
    updatePattern();
    final offset = 1 + taggedUser['display']?.length as int? ?? 0;
    updatePositionsWhenAddNew(startPos, offset - searchText.length + 1);
  }

  void updatePositionsWhenAddNew(int currentPost, int offset) {
    taggedUsers.forEach((taggedUser) {
      if (taggedUser['start'] > currentPost) {
        taggedUser['start'] = taggedUser['start'] + offset;
      }
    });
  }

  void updateMentionPositions(int currentPost, int offset) {
    taggedUsers.forEach((taggedUser) {
      if (taggedUser['start'] >= currentPost) {
        taggedUser['start'] = taggedUser['start'] + offset;
      }
    });
  }

  void updatePattern() {
    if (taggedUsers.isEmpty) {
      return;
    }
    final taggedUserString =
        taggedUsers.map((e) => '@' + e['display']).toList().join('|');
    _pattern = taggedUserString;
  }

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    var children = <InlineSpan>[];
    var postedTexts = <String>[];
    var ids = <dynamic>[];

    if (_pattern == null || _pattern == '()') {
      children.add(TextSpan(text: text, style: style));
      postedTexts.add(text);
    } else {
      text.splitMapJoin(
        RegExp('$_pattern'),
        onMatch: (Match match) {
          if (taggedUsers.isNotEmpty) {
            var element = match[0]!;
            element = element.substring(1);
            final first = taggedUsers.firstWhere(
                (e) => e['display'] == element && e['start'] == match.start,
                orElse: () => {'display': null});
            if (first['display'] != null && first['start'] == match.start) {
              children.add(
                TextSpan(
                  text: match[0],
                  style: mentionStyle,
                ),
              );
              postedTexts.add('[**${first['id']}**]');
              ids.add(first['id']);
            } else {
              children.add(
                TextSpan(
                  text: match[0],
                  style: style,
                ),
              );
              postedTexts.add(match[0] ?? '');
            }
          }

          return '';
        },
        onNonMatch: (String text) {
          children.add(TextSpan(text: text, style: style));
          postedTexts.add(text);
          return '';
        },
      );
    }

    outputText = postedTexts.join();
    mentionIds = ids;
    return TextSpan(style: style, children: children);
  }
}
