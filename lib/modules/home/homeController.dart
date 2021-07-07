enum Screens { home, createBoleto }

class HomeController {
  var currentPage = Screens.home;

  void setPage(Screens value) {
    currentPage = value;
  }
}
