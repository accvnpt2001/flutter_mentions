part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    required this.data,
    required this.onTap,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Container(
            decoration:
                suggestionListDecoration ?? BoxDecoration(color: Colors.white),
            child: ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onTap(data[index]);
                  },
                  child: suggestionBuilder != null
                      ? suggestionBuilder!(data[index])
                      : Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            data[index]['display'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                );
              },
            ),
          )
        : Container();
  }
}
