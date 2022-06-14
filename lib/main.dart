import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  final game = FlameGame();
  runApp(GameWidget(game: MyGeorgeGame()));
}

class MyGeorgeGame extends FlameGame with TapDetector {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;

  late SpriteAnimationComponent george;

  // 0=idle 1=down 2=left 3=up 4=right
  int direction = 0;

  double animationSpeed = .2;

  Future<void> onLoad() async {
    await super.onLoad();

    final spriteSheet = SpriteSheet(
        image: await images.load('hero-sprites.png'), srcSize: Vector2(32, 48));

    downAnimation = spriteSheet.createAnimation(
      row: 0,
      to: 4,
      stepTime: animationSpeed,
      loop: true,
    );
    leftAnimation = spriteSheet.createAnimation(
      row: 1,
      to: 4,
      stepTime: animationSpeed,
      loop: true,
    );
    rightAnimation = spriteSheet.createAnimation(
      row: 2,
      to: 4,
      stepTime: animationSpeed,
      loop: true,
    );
    upAnimation = spriteSheet.createAnimation(
      row: 3,
      to: 4,
      stepTime: animationSpeed,
      loop: true,
    );
    idleAnimation = spriteSheet.createAnimation(
      row: 0,
      to: 1,
      stepTime: 0.5,
      loop: true,
    );

    george = SpriteAnimationComponent()
      ..animation = idleAnimation
      ..position = Vector2(50, 200)
      ..size = Vector2.all(100);

    add(george);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case 0:
        george.animation = idleAnimation;
        break;
      case 1:
        george.animation = downAnimation;
        george.y += 1;
        break;
      case 2:
        george.animation = leftAnimation;
        george.x -= 1;

        break;
      case 3:
        george.animation = upAnimation;
        george.y -= 1;

        break;
      case 4:
        george.animation = rightAnimation;
        george.x += 1;

        break;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
    print('changed direction');
  }
}
