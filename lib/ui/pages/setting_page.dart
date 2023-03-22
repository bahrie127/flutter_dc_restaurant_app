import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/home_page.dart';

import '../../cubit/daily_reminder/daily_reminder_cubit.dart';
import 'favorite_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  
  void handleOnTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const FavoritePage();
      }));
    }

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  void initState() {
    context.read<DailyReminderCubit>().getDailyReminder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.schedule_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  flex: 3,
                  child: Text('Daily Reminder Scheduler',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                const Spacer(),
                BlocBuilder<DailyReminderCubit, DailyReminderState>(
                  builder: (context, state) {

                    return Switch(
                      activeColor: Colors.orange,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.withOpacity(.5),
                      value: state is DailyReinderLoaded ? state.status : false,
                      onChanged: (value) {
                        context.read<DailyReminderCubit>().setReminder(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: handleOnTap,
        currentIndex: 2,
      ),
    );
  }
}
