import 'package:rive/rive.dart';
export 'package:rive/rive.dart';

class RiveModel {
  static StateMachineController getRiveController(artboard,
      {stateMachineName = "State Machine 1"}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  late SMINumber? inputInt;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
    this.inputInt,
  });

  set setInput(SMIBool status) {
    input = status;
  }

  set setInt(SMINumber number) {
    inputInt = number;
  }
}

//door 1
RiveAsset logo = RiveAsset('lib/assets/rive/logo.riv',
    artboard: "LOGO", stateMachineName: "State Machine 1", title: "Logo");

// bomb
RiveAsset bomb = RiveAsset('lib/assets/rive/bomb.riv',
    artboard: 'bomb',
    stateMachineName: 'bomb_activity',
    title: 'bomb'); // numbers
