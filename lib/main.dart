import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Tasks',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Raleway',
        buttonColor: Colors.orange,
        textTheme: TextTheme(
          button: TextStyle( color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600, decorationColor: Colors.white),
        ),
        accentColor: Colors.deepOrangeAccent,
      ),
      home: HomePage(),
    );
  }
}


final TextStyle inputTextStyle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold,
  color: Colors.black
);
class Task {
  String title;
  String subTitle;
  String priority;
  bool isDone;
  Task({@required this.title, this.subTitle, this.priority, this.isDone});
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Task> tasks = [
    Task(
        title: 'Buy presents',
        subTitle: 'Buy presents for Holi',
        priority: 'HIGH',
        isDone: false),
    Task(
        title: 'Walk the dog',
        subTitle: 'Walk the doggie',
        priority: 'MEDIUM',
        isDone: true),
    Task(
        title: 'Duolingo',
        subTitle: 'Learn Deutsche, continue the streak',
        priority: 'LOW',
        isDone: false),
    Task(
        title: 'Learn flare',
        subTitle: 'Learn to integrate flare with flutter',
        priority: 'HIGH',
        isDone: false),
  ];

  List<Widget> cards =
      new List.generate(tasks.length, (i) => SingleCard(task: tasks[i]));

  addTask() async {
    print('adding new task');
//    setState(() {
//    });
    Task newTask = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewTask(),
        ));

    setState(() {
      if(newTask != null){
        tasks.add(newTask);
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Task successfully added'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Container(
                decoration: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.orange)),
                height: 54.0,
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            '25',
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text('Tuesday',
                                style: TextStyle(fontWeight: FontWeight.w600))),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text( 'Dec 2018',
                                style: TextStyle(fontWeight: FontWeight.w600))),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 60.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: addTask,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.blue.shade400,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'NEW TASK',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text(
              "TODO Tasks",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) => SingleCard(task: tasks[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  final formKey = GlobalKey<FormState>();

  String title, subTitle, priority = 'HIGH';

  Task newTask;

  List<String> priorList = ['HIGH', 'MEDIUM', 'LOW'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Task",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(4.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                          style: inputTextStyle,
                          decoration: InputDecoration(
                            labelText: 'TODO Name',

                          ),
                          onSaved: (value) {
                            title = value;
                          },
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                          style: inputTextStyle,
                          decoration: InputDecoration(
                            labelText: 'TODO Description',
                          ),
                          onSaved: (value) {
                            subTitle = value;
                          },
                        ),
                        DropdownButton<String>(

                          value: priority,
                          onChanged: (String newValue) {
                            priority = newValue;
                            setState(() {

                            });
                          },
                          items:
                          priorList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        RaisedButton(
                          child: Text("Add Task", style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              newTask = Task(
                                  title: title,
                                  subTitle: subTitle,
                                  priority: priority,
                                  isDone: false);
                              Navigator.pop(context, newTask);
                            }
                          },
                        )
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SingleCard extends StatefulWidget {
  final Task task;
  SingleCard({Key key, @required this.task}) : super(key: key);
  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  Color getColor(String type, bool isDone) {
    if (isDone) {
      return Colors.green;
    } else {
      if (type == 'HIGH')
        return Colors.red;
      else if (type == 'MEDIUM')
        return Colors.deepOrange;
      else if (type == 'LOW') return Colors.blue;
    }
  }

  IconButton getCheckIcon(bool isDone) {
    if (isDone) {
      return IconButton(
        icon: FlareActor("assets/success_check.flr", alignment:Alignment.center, animation: "Untitled", ),
        iconSize: 25.0,
      );
    } else
      return IconButton(
        icon: Icon(Icons.radio_button_unchecked),
        color: Colors.white,
        iconSize: 25.0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () => {print('show-task-details')},
        child: Card(
          color: getColor(this.widget.task.priority, this.widget.task.isDone),
          margin: EdgeInsets.all(8.0),
          elevation: 4.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            splashColor: Colors.greenAccent,
            onTap: () => {
                  setState(() {
                    widget.task.isDone = !widget.task.isDone;
                  })
                },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          this.widget.task.priority + ' PRIORITY',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          this.widget.task.title,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          this.widget.task.subTitle,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  getCheckIcon(this.widget.task.isDone),
                ],
              ),
            ),
          ),
        ));
  }
}
