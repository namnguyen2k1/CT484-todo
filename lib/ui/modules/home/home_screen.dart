import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double widthCategory = deviceSize.width * 0.4;
    final double heightCategory = 200.00;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Nguyễn Nam'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/avatar.gif'),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 50.0),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('99 done'),
                  icon: const Icon(Icons.done),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                  label: const Text('10 pending'),
                  icon: const Icon(Icons.pending),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.view_comfortable),
                    SizedBox(width: 10),
                    Text('All Category'),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text(''),
                )
              ],
            ),
          ),
          Container(
            height: heightCategory,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: widthCategory,
                  padding: const EdgeInsets.all(10),
                  child: const Card(
                    color: Colors.red,
                    child: Text('Current Task'),
                  ),
                ),
                Container(
                  width: widthCategory,
                  padding: const EdgeInsets.all(10),
                  child: const Card(
                    color: Colors.blue,
                    child: Text('Current Task'),
                  ),
                ),
                Container(
                  width: widthCategory,
                  padding: const EdgeInsets.all(10),
                  child: const Card(
                    color: Colors.green,
                    child: Text('Current Task'),
                  ),
                ),
                Container(
                  width: widthCategory,
                  padding: const EdgeInsets.all(10),
                  child: const Card(
                    color: Colors.yellow,
                    child: Text('Current Task'),
                  ),
                ),
                Container(
                  width: widthCategory,
                  padding: const EdgeInsets.all(10),
                  child: const Card(
                    color: Colors.teal,
                    child: Text('Current Task'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Task Daily'),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                  label: const Text('See All'),
                )
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 10.0,
            percent: 0.9,
            center: const Text(
              "90%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            progressColor: Colors.green,
            footer: const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                "Tasks of day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
