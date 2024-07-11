import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_bug/main_page.dart';

class VolumeSettingsDialog extends ConsumerStatefulWidget {
  const VolumeSettingsDialog({super.key});

  @override
  _VolumeSettingsDialogState createState() => _VolumeSettingsDialogState();
}

class _VolumeSettingsDialogState extends ConsumerState<VolumeSettingsDialog> {
  double? _volume;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(mainPageViewModelProvider);
    _volume = viewModel.backgroundPlayer.volume;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(mainPageViewModelProvider);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      backgroundColor: Colors.grey[900],
      title: const Text(
        '볼륨 설정',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            '볼륨 조절',
            style: TextStyle(color: Colors.white),
          ),
          Slider(
            value: _volume!,
            onChanged: (value) {
              setState(() {
                _volume = value;
              });
              viewModel.setAudioVolume(value);
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: '${(_volume! * 100).toInt()}%',
          ),
        ],
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
}
