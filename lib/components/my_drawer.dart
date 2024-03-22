import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "HabitTacker",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
             const Text(
              "An AppVista Product",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
                onPressed: () {
                   Navigator.push(
      context,
      MaterialPageRoute(
         builder: (context) => const Settings(),
      ),
    );
                  },  
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                )),
                
            const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                onPressed: () {
                   Navigator.push(
                      context,
                       MaterialPageRoute(
                          builder: (context) => const About(),
                           ),
                        );
                  },  
                child: Text(
                  "About",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                )),
              Padding(padding: EdgeInsets.only(top: 100)),
              Text("copyright ©️ 2024",style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold ),)

            ],
        ),
      ),
    );
  }
  
 
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
    backgroundColor: Theme.of(context).colorScheme.background,
     appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Settings"),
     ),
     body: Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Dark/Light Mode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value){
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
              }
          )
        ],
      ),
     ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
     appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("About"),
     ),
     body: Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), 
       child:const Text("Version:1.3.0\n\nContact Us:appvista2024@gmail.com\n",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
     ),
    );
  }
}