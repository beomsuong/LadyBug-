import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/data_class.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item.dart';
import 'package:lady_bug/main_page_view_model.dart';
import 'package:lady_bug/player_character/player_character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainPageViewModelProvider =
    ChangeNotifierProvider((ref) => MainPageViewModel());

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  GameData gameData = GameData();

  @override
  void initState() {
    super.initState();
    ref.read(mainPageViewModelProvider.notifier).build(this);
  }

  @override
  void dispose() {
    ref.read(mainPageViewModelProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(mainPageViewModelProvider);
    screenHeight = MediaQuery.sizeOf(context).height; // 화면 크기 변경하면 바로 변경
    screenWidth = MediaQuery.sizeOf(context).width; // 화면 크기 변경하면 바로 변경
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return CustomPaint(
                painter: PlayerCharacter(),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return Stack(
                children: gameData.itemList.map((item) {
                  return CustomPaint(
                    painter: ItemPainter(item),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Joystick(
                mode: JoystickMode.all,
                listener: (details) {
                  viewModel.updatePosition(details);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                viewModel.addItem();
              },
              child: Container(
                color: Colors.amber,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
