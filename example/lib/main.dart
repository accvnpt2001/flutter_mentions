import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) => Portal(child: child!),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  bool showSuggestions = false;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    users = [
      {
        'id': '61as61fsa',
        'display': 'fayeedP',
        'full_name': 'Fayeed Pawaskar',
        'photo':
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      },
      {
        'id': '61asasgasgsag6a',
        'display': 'khaled',
        'full_name': 'DJ Khaled',
        'photo':
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      },
      {
        'id': 'asfgasga41',
        'display': 'markT',
        'full_name': 'Mark Twain',
        'photo':
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      },
      {
        'id': 'asfsaf451a',
        'display': 'JhonL',
        'full_name': 'Jhon Legend',
        'photo':
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      },
      {
        'id': 'asfsaf451aafae',
        'display': 'CR7',
        'full_name': 'Criatiano Ronaldo',
        'photo':
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          showSuggestions
              ? Expanded(
                  child: OptionList(
                  data: users,
                  suggestionBuilder: (data) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['photo'],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(data['full_name']),
                              Text('@${data['display']}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  onTap: (value) {
                    key.currentState!.controller!.addMention(value);
                  },
                ))
              : Container(),
          ElevatedButton(
            child: Text('Change Mentions'),
            onPressed: () {
              debugPrint(
                  'outputText = ${key.currentState!.controller!.outputText}');
              setState(() {
                users = [
                  {
                    'id': '61as61fsa',
                    'display': 'user1',
                    'full_name': 'i am user1',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': '61asasgasgsag6a',
                    'display': 'user2',
                    'full_name': 'i am user2',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': 'asfgasga41',
                    'display': 'user3',
                    'full_name': 'i am user3',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': 'asfsaf451a',
                    'display': 'user4',
                    'full_name': 'i am user4',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': 'asfsaf451aafae',
                    'display': 'Messi10',
                    'full_name': 'Leo Messi',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                ];
              });
            },
          ),
          Container(
            child: FlutterMentions(
              key: key,
              suggestionPosition: SuggestionPosition.Top,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(hintText: 'hello'),
              onSearchChanged: (trigger, value) => {
                debugPrint('trigger = $trigger, value = $value'),
              },
              onSuggestionVisibleChanged: (status) {
                setState(() {
                  showSuggestions = status;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
