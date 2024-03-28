
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool status_general_notif = false;
  bool status_sound = false;
  bool status_vibrate = false;
  bool status_updates = false;
  bool status_payment = true;
  bool status_service = true;
  bool status_tips = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Notification"),
          leading: IconButton(
              onPressed: () {
                context.pushPage(profiletest());
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Common",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("General Notification"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_general_notif,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_general_notif = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sound"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_sound,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_sound = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_vibrate,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_vibrate = val;
                    });
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.orange,
            ),
            const Text(
              "System & Services Update",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("App Updates"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_updates,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_updates = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Payment Request"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_payment,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_payment = val;
                    });
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.orange,
            ),
            const Text(
              "Others",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("New Service Available"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_service,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_service = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("New Tips Available"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_tips,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_tips = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
