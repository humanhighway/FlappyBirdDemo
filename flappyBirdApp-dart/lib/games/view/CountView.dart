
part of GameLib;

class CountView extends Sprite {
  
  Sprite _container;
  int _currentValue;
  
  CountView() {
    _container = new Sprite();
    addChild(_container);
  }
  
  void set count(int value){
    
    if (value == _currentValue) {
      return;
    }
    
    _currentValue = value;
    
    while(_container.numChildren > 0) {
      _container.removeChildAt(0);
    }

    String strValue = value.toString();
    List<String>strSplit = strValue.split("");
    double tx = 0.0;
   
    for (var i = 0; i < strSplit.length; i++) {
      Bitmap b = getValueBitmap(int.parse(strSplit[i]));
      _container.addChild(b);
      b.x = tx;
      tx += _container.width + 5;
    }
    _container.x = -_container.width * .5;
    
    if (_currentValue != 0) {
      resources.getSound("Point").play();
    }
  }
  
  Bitmap getValueBitmap(int value) {
    switch(value) {
      case 0:
        return new Num_0();
      case 1:
        return new Num_1();
      case 2:
        return new Num_2();
      case 3:
        return new Num_3();
      case 4:
        return new Num_4();
      case 5:
        return new Num_5();
      case 6:
        return new Num_6();
      case 7:
        return new Num_7();
      case 8:
        return new Num_8();
      case 9:
        return new Num_9();
    }
  }
}
