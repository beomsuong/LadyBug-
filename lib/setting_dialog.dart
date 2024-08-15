import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_bug/main_page.dart';
import 'package:lady_bug/volume_settings_dialog.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainPageViewModelProvider);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      backgroundColor: Colors.grey[900],
      title: const Text(
        '설정',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            menuButton(
              context,
              icon: Icons.question_mark,
              label: '도움말',
              color: Colors.blueGrey,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const GameDescriptionDialog();
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            menuButton(
              context,
              icon: Icons.settings,
              label: '게임 세팅',
              color: Colors.blueGrey,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const VolumeSettingsDialog();
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            menuButton(
              context,
              icon: Icons.refresh,
              label: '게임 리셋',
              color: Colors.redAccent,
              onPressed: () {
                viewModel.resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('닫기', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget menuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class GameDescriptionDialog extends StatelessWidget {
  const GameDescriptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.black87,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '게임 설명',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.blueAccent,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '게임 목표: 가능한 오래 살아남아 높은 점수를 기록하세요!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildItemDescription(
                      iconColor: Colors.brown,
                      label: '쉴드',
                      description: '일정 시간 동안 무적 상태가 됩니다.',
                    ),
                  ),
                  Expanded(
                    child: _buildItemDescription(
                      iconColor: Colors.red,
                      label: '속도업',
                      description: '일정 시간 동안 이동 속도가 빨라집니다.',
                    ),
                  ),
                  Expanded(
                    child: _buildItemDescription(
                      iconColor: Colors.blue,
                      label: '속도다운',
                      description: '일정 시간 동안 적의 속도가 느려집니다.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildItemDescription(
                iconColor: Colors.green,
                label: '적',
                description: '적에게 맞으면 체력이 줄어듭니다.',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 아이템 설명 빌더 함수
  Widget _buildItemDescription({
    required Color iconColor,
    required String label,
    required String description,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: iconColor,
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
