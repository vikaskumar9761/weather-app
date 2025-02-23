import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/Weather_services.dart';
import 'package:weather/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final WeatherServices _weatherServices = WeatherServices();
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  //crate a object for weather class so access the object

  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherServices.feachWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching weather data"))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(


          gradient: _weather != null && (_weather!.description.toLowerCase().contains('rain'))
              ? const LinearGradient(
            colors: [Colors.grey, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : _weather != null && (_weather!.description.toLowerCase().contains('clear'))
              ? const LinearGradient(
            colors: [Colors.orangeAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : const LinearGradient(
            colors: [Colors.grey, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),


        ),

        child: SingleChildScrollView(
          child:  Padding(
            padding:const EdgeInsets.all(16.0),
            child:  Column(
              children: [
                const SizedBox(height: 25,),
                const Text('Weather App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _controller,
                  style:const TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Your city Name",
                    hintStyle:const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor:const Color.fromARGB(110, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: _getWeather,
                  style:ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(209, 125, 155, 170),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),

                    )
                  ),
                    child: Text("Get Weather",style: TextStyle(fontSize: 18),),
                ),

                if(_isLoading)
                  Padding(padding: EdgeInsets.all(20),child: CircularProgressIndicator(color: Colors.white,),),

                if(_weather!=null)
                  WeatherCard(weather: _weather!)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
