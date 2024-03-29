import 'dart:async'; 
import 'package:flutter/material.dart'; 

void main() {
  runApp(TimerApp()); 
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, 
      title: 'Timer App', 
      theme: ThemeData(
        
        primarySwatch:
            const Color.fromARGB(255, 202, 111, 232), 
        elevatedButtonTheme: ElevatedButtonThemeData(

          style: ButtonStyle(
            
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 139, 143, 223)), 
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white), 
          ),
        ),
      ),
      home:
          TimerPageOne(), 
    );
  }
}

class TimerPageOne extends StatefulWidget {
  @override
  _TimerPageOneState createState() =>
      _TimerPageOneState(); 
}

class _TimerPageOneState extends State<TimerPageOne> {
  late TextEditingController
      _controller; 
  int _minutes = 0; 

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(); 
  }

  @override
  void dispose() {
    _controller
        .dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, 
            crossAxisAlignment: CrossAxisAlignment
                .center, 
            children: [
              Text(
                'INPUT WAKTU', 
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20), 
              Container(
                width: 200, 
                child: TextField(
                  controller:
                      _controller, 
                  keyboardType: TextInputType
                      .number, 
                  textAlign:
                      TextAlign.center, 
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(), 
                  ),
                  onChanged: (value) {
                    setState(() {
                      _minutes = int.tryParse(value) ??
                          0; 
                    });
                  },
                ),
              ),
              SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  if (_minutes > 0) {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerPageTwo(
                          minutes:
                              _minutes, 
                        ),
                      ),
                    );
                  }
                },
                child: Text('MULAI'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPageTwo extends StatefulWidget {
  final int minutes; 

  TimerPageTwo(
      {required this.minutes}); 

  @override
  _TimerPageTwoState createState() =>
      _TimerPageTwoState(); 
}

class _TimerPageTwoState extends State<TimerPageTwo> {
  late Timer _timer; 
  int _minutes = 0; 
  int _seconds = 0; 
  bool _isTimerRunning =
      true; 

  @override
  void initState() {
    super.initState();
    _minutes =
        widget.minutes; 
    _startTimer(); 
  }

  void _startTimer() {
    int totalSeconds =
        _minutes * 60; 
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_isTimerRunning) {
          
          if (totalSeconds > 0) {
            totalSeconds--;
            _minutes = totalSeconds ~/
                60; 
            _seconds =
                totalSeconds % 60; 
            if (totalSeconds == 0) {
              
              timer.cancel(); 
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TimerPageThree()), 
              );
            }
          } else {
            timer.cancel(); 
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, 
            crossAxisAlignment: CrossAxisAlignment
                .center, 
            children: [
              Container(
                width: 200, 
                height: 200, 
                decoration: BoxDecoration(
                  color: Colors
                      .grey[200], 
                  borderRadius: BorderRadius.circular(
                      10), 
                ),
                child: Center(
                  child: Text(
                    '$_minutes:${_seconds.toString().padLeft(2, '0')}', 
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isTimerRunning =
                        !_isTimerRunning; 
                  });
                },
                child: Text(_isTimerRunning
                    ? 'BERHENTI'
                    : 'LANJUTKAN'), 
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer
        .cancel(); 
    super.dispose();
  }
}

class TimerPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'), 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, 
            crossAxisAlignment: CrossAxisAlignment
                .center, 
            children: [
              Text(
                'Waktu Habis!', 
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TimerPageOne()), 
                  );
                },
                child: Text('MULAI ULANG'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
