import 'dart:math';

class Home {
  int many = 100;
  int food = 50;
  int foodForCat = 30;
  int dirt = 0;

  List<int> eat(int hungry) {
    if (this.food >= hungry) {
      this.food -= hungry;
      return [this.food, hungry]; // возращает скок осталось, и сколько съел
    } else if (this.food != 0) {
      int afforableFood = hungry - this.food;
      this.food -= afforableFood;
      return [
        this.food,
        afforableFood
      ]; // возращает скок осталось, и сколько съел
    } else {
      return [0, 0]; // возращает скок осталось, и сколько съел
    }
  }

  List<int> catEat(int hungry) {
    if (this.foodForCat >= hungry) {
      this.foodForCat -= hungry;
      return [
        this.foodForCat,
        hungry
      ]; // возращает скок осталось, и сколько съел
    } else if (this.food != 0) {
      int afforableFood = hungry - this.foodForCat;
      this.foodForCat -= afforableFood;
      return [
        this.foodForCat,
        afforableFood
      ]; // возращает скок осталось, и сколько съел
    } else {
      return [0, 0]; // возращает скок осталось, и сколько съел
    }
  }

  int clean() {
    if (this.dirt >= 100) {
      this.dirt -= 100;
      return this.dirt;
    } else {
      this.dirt = 0;
      return this.dirt;
    }
  }

  int work() {
    this.many += 150;
    return this.many;
  }

  int buyF() {
    int forBuy = 50 - this.food;
    if (forBuy < this.many) {
      this.many = this.many - forBuy;
      this.food = this.food + forBuy;
      return this.food;
    } else if (this.many > 0) {
      this.food += this.many;
      this.many = 0;
      return this.food;
    } else {
      return 0;
    }
  }

  int buyS() {
    if (this.many >= 350) {
      this.many -= 350;
      return 60;
    } else {
      return 0;
    }
  }
}

// ---------------------------------------------------------------------------------------------------------
class Cat {
  String name = "";
  int hungry = 30;

  Cat(String nameCat) : name = nameCat;

  void destroyHome() {
    print("Кот дерет обои");
  }

  void sleeping() {
    print("Кот уснул от безделья");
  }
}

// ---------------------------------------------------------------------------------------------------------
class Person {
  String name = "";
  int huppenes = 100;
  int hungry = 30;

  Person(String Inputname) : name = Inputname;
}

// ---------------------------------------------------------------------------------------------------------
class Actions {
  String lastnameFamily;
  int allFood = 0;
  int allMany = 0;
  int allShuba = 0;

  Home home;
  Cat cat = Cat("Lilit");
  Person husband = Person("Alex");
  Person wife = Person("Eliza");
  Actions(this.lastnameFamily)
      : home = Home(),
        cat = Cat("Lilit"),
        husband = Person("Alex"),
        wife = Person("Eliza");

  bool eating(Person classObj) {
    List<int> result = home.eat(30 - classObj.hungry);

    if (result[0] == 0 && result[1] == 0) {
      print("В доме нет еды");
      return true;
    }

    classObj.hungry += result[1];
    print(
        '${classObj.name} съело ${result[1]} единиц еды. Осталось еды: ${result[0]}.');
    this.allFood += result[1];
    return false;
  }

  bool catEating() {
    List<int> result = home.catEat(10 - cat.hungry);

    if (result[0] == 0 && result[1] == 0) {
      print("В доме нет еды");
      return true;
    }

    cat.hungry += result[1];
    print(
        '${cat.name} съело ${result[1]} единиц еды. Осталось еды: ${result[0]}.');
    return false;
  }

  void playing() {
    husband.hungry -= 10;

    husband.huppenes += 20;
    print(
        "${husband.name} поиграл в WoT. Его уровень счастья ${husband.huppenes}");
  }

  void working() {
    husband.hungry -= 10;

    int result = home.work();
    print("${husband.name} работал. Теперь в доме $result денег");
    this.allMany += 150;
  }

  void buyFood() {
    wife.hungry -= 10;

    int result = home.buyF();
    if (result == 0) {
      print("${wife.name} НЕ купила еды.У нас нет денег");
    } else if (result > 0) {
      print("${wife.name} купила еды. У нас есть $result единиц еды");
    } else {
      print("Что то не так");
    }
  }

  void buyShuba() {
    wife.hungry -= 10;

    int result = home.buyS();
    if (result == 60) {
      wife.huppenes += 60;
      print(
          "${wife.name} купила шубу. Она счастлива! У неё ${wife.huppenes} единиц счастья");
      this.allShuba += 1;
    } else {
      print("Жена не купила шубу. У неё ${wife.huppenes} единиц счастья");
    }
  }

  void cleaning() {
    wife.hungry -= 10;

    int result = home.clean();
    print("${wife.name} вытерла пыль с мужа. В доме $result единиц грязи");
  }

  void playingWithCatInPocker(Person classObj) {
    classObj.hungry -= 2;
    classObj.huppenes += 5;
    print("${classObj.name} гладит кота. Он стал веселее");
  }

  bool? followLiveForHusband({int condition = 0}) {
    home.dirt += 2;
    if (husband.hungry <= 10 && home.food > 10 || condition == 1) {
      return this.eating(husband);
    } else if (home.many <= 20 || condition == 3) {
      this.working();
      return null;
    } else if (husband.huppenes <= 5 || condition == 4) {
      this.playingWithCatInPocker(husband);
      return null;
    } else if (husband.huppenes <= 10 || condition == 2) {
      this.playing();
      return null;
    } else {
      int randomNumber = Random().nextInt(4) + 1;
      this.followLiveForHusband(condition: randomNumber);
      return null;
    }
  }

  bool? followLiveForWife({int condition = 0}) {
    home.dirt += 3;
    if (wife.hungry <= 10 && home.food > 10 || condition == 1) {
      return this.eating(wife);
    } else if (home.food <= 10 || condition == 3) {
      this.buyFood();
      return null;
    } else if (wife.huppenes <= 5 || condition == 5) {
      this.playingWithCatInPocker(wife);
      return null;
    } else if (wife.huppenes <= 10 || condition == 2) {
      this.buyShuba();
      return null;
    } else if (home.dirt >= 80 || condition == 4) {
      this.cleaning();
      return null;
    } else {
      int randomNumber = Random().nextInt(5) + 1;
      this.followLiveForWife(condition: randomNumber);
      return null;
    }
  }

  bool? followLiveForCat({int condition = 0}) {
    if (cat.hungry <= 10 || condition == 1) {
      return this.catEating();
    } else if (condition == 2) {
      cat.sleeping();
      return null;
    } else if (condition == 3) {
      cat.destroyHome();
      home.dirt += 5;
      return null;
    } else {
      int randomNumber = Random().nextInt(3) + 1;
      this.followLiveForCat(condition: randomNumber);
      return null;
    }
  }
}

void main() {
  Actions actionPanel = Actions("Воронины");

  for (int i = 1; i < 365; i++) {
    print("-----------------------------------------");
    print('День $i');

    if (actionPanel.followLiveForHusband() == true) {
      print("Нет еды");
      return;
    }

    if (actionPanel.followLiveForWife() == true) {
      print("Нет еды");
      return;
    }

    if (actionPanel.followLiveForCat() == true) {
      print("Нет еды");
      return;
    }
  }
  print("-----------------------------------------");
  print("Всего еды скушано: ${actionPanel.allFood}");
  print("Всего денег заработано: ${actionPanel.allMany}");
  print("Всего шуб куплено: ${actionPanel.allShuba}");
}
