import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: const MyHomePage(title: 'Click Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void showCupertinoSnackBar({
    required BuildContext context,

    int durationMillis = 3000,
  }) {
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 8.0,
        left: 8.0,
        right: 8.0,
        child: CupertinoPopupSurface(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Text(
              "Add some clicks to Start your Count",
              style: TextStyle(
                fontSize: 14.0,
                color: CupertinoColors.secondaryLabel,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
    Future.delayed(
      Duration(milliseconds: durationMillis),
      overlayEntry.remove,
    );
    Overlay.of(Navigator.of(context).context)?.insert(overlayEntry);
  }


  int _counter = 0;
void _showCupertinoAlertDialog(BuildContext context){
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Are You sure '),
      content: const Text(' You Want to Proceed with this Action?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            _resetClickCounter();
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  void _resetClickCounter(){
    setState(() {
      _counter=0;
    });
  }
  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
      middle: const Text('Click Counter'),
      trailing: CupertinoButton(child:Icon(Icons.refresh_rounded) , onPressed: ()=>_showCupertinoAlertDialog(context),),
    ),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your click Count ${_counter}"
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CupertinoButton(child: Icon(Icons.ad), onPressed: onPressed)
            CupertinoButton(child: Icon(Icons.add_circle), onPressed: _incrementCounter),
            CupertinoButton(child: Icon(Icons.refresh), onPressed: () =>_showCupertinoAlertDialog(context)),
          ],
        ),
      ],
    )
);
  }
}
