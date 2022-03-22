String serviceHttp =
//"https://exxxp.herokuapp.com";
    "https://kalite-takip-yonetim-sistemi.herokuapp.com";
// "https://mergen-kalite-takip-sistemi.herokuapp.com";
//"http://91.151.89.195:8090";

const rootRoute = "/home";

const employeesPageDisplayName = "Personel";
const employeesPageRoute = "/employees";

const myActivitiesPageDisplayName = "Aktivite";
const myActivitiesPageRoute = "/myActivitiesPage";

const formsPageDisplayName = "Form";
const formsPageRoute = "/forms";

const settingsPageDisplayName = "Seçenekler";
const settingsPageRoute = "/settingsPage";

///Login - SignUp Sayfaları

const loginPageDisplayName = "Giriş Yap";
const loginPageRoute = "/login";

const signUpPageDisplayName = "Kayıt Ol";
const signUpPageRoute = "/signUp";

const newActivityPageDisplayName = "Yeni Aktivite";
const newActivityPageRoute = "/newActivity";

const vacationRequestPageDisplayName = "İzin Talepleri";
const vacationRequestPageRoute = "/vacationRequests";

const activityEvaluationPageDisplayName = "Aktivite Değerlendirme";
const activityEvaluationPageRoute = "/activityEvaluation";

class MenuItem {
  final String name;
  final String route;
  final int color;

  MenuItem(
    this.name,
    this.route,
    this.color,
  );
}

List<MenuItem> sideMenuItems = [
  MenuItem(
    employeesPageDisplayName,
    employeesPageRoute,
    0xFFFF0000.toInt(),
  ),
  MenuItem(
    vacationRequestPageDisplayName,
    vacationRequestPageRoute,
    0xDDDDDD00.toInt(),
  ),
  MenuItem(
    settingsPageDisplayName,
    settingsPageRoute,
    0xFFF000F0.toInt(),
  ),
  MenuItem(
    myActivitiesPageDisplayName,
    myActivitiesPageRoute,
    0xFF0000FF.toInt(),
  ),
  MenuItem(
    formsPageDisplayName,
    formsPageRoute,
    0xFF00FF00.toInt(),
  ),
];
