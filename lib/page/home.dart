import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  Map<dynamic, dynamic>  data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings?.arguments as Map<dynamic, dynamic>;

    //set background image

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'ni8.jpg';

    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.black;

    Color getTextColor() {
      return data['isDayTime'] ? Colors.black : Colors.white;
    }

    return Scaffold(
      backgroundColor:bgColor ,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                ElevatedButton.icon(onPressed: () async {
                 dynamic result = await Navigator.pushNamed(context, '/location');
                 setState(() {
                   data ={
                     'time': result['time'],
                     'location': result['location'],
                     'isDayTime': result['isDayTime'],
                     'flag': result['flag']
                   };
                 });
                },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  icon: Icon(Icons.edit_location,color: getTextColor(),),
                label: Text('Edit location',
                  style: TextStyle(
                    color: getTextColor(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                          color:  getTextColor()
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                 Text(data['time'],style: TextStyle(
                   fontSize: 66,
                     color: getTextColor()
                 ),)
              ],
            ),
          ),
        ),
      )
    );
  }
}