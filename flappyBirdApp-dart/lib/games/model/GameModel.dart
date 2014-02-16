part of GameLib;

class GameModel {
  
  static final GameModel _singleton = new GameModel._internal();
  
  static const int BEGIN = 0;
  static const int PLAYING = 1;
  static const int GAME_OVER = 2;
  static const int WAIT_TO_BACK_BEGIN = 3;
  
  int status = BEGIN;
  bool isBirdLanding = false;
  int gameWidth;
  int gameHeight;
  int speed = 4;

  factory GameModel() {
    return _singleton;
  }

  GameModel._internal();
  
  bool get isGameOver => status == GAME_OVER;
  
  void reset () {
    isBirdLanding = false;
    status = GameModel.BEGIN;
  }
  
}