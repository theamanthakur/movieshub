import 'package:intl/intl.dart';
import 'package:movieshub/config/config.dart';

class ProfileController extends BaseController{

  final listDays = RxList<String>();
  List<String> days = [
    'Mon',
    'Tues',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];


  Map<String, List<String>> timeTable = {
    'Mon': ['Math', 'Physics', 'English', 'Chemistry'],
    'Tues': ['Biology', 'Math', 'Computer', 'English'],
    'Wed': ['Physics', 'Chemistry', 'Math', 'Physical Ed.'],
    'Thu': ['English', 'Biology', 'Computer', 'Math'],
    'Fri': ['Math', 'Physics', 'English', 'Chemistry'],
    'Sat': ['Biology', 'Computer', 'Physical Ed.'],
    'Sun': [], // Sunday off
  };

  Map<String, String> subjectTeacherMap = {
    'Math': 'Ravi Verma',
    'Physics': 'Vikram Rao',
    'English': 'Anita Sharma',
    'Chemistry': 'Sunita Patel',
    'Biology': 'Neha Reddy',
    'Computer': 'Amitabh Sengupta',
    'Physical Ed.': 'Suresh Nair',
  };


  final listPeriods = RxList<String>();
  final listTeachers = RxList<String>();

  var selectedDay = "".obs;

  List<Notice> noticeList = [
    Notice(
      title: 'Mid-Term Exam Schedule',
      subtitle: 'Exams will begin from 15th September. Check full schedule below.',
      fileUrl: 'https://k8school.com/wp-content/uploads/2023/11/Why-Are-Exams-Important-How-Do-They-Improve-Learning.jpg',
      dateTime: DateTime(2025, 9, 10, 10, 30),
      targetClasses: '6th - 10th',
    ),
    Notice(
      title: 'Science Fair Participation',
      subtitle: 'Students of class 8 to 12 are invited to participate in the annual science fair.',
      fileUrl: 'https://static.vecteezy.com/system/resources/thumbnails/000/202/099/small_2x/Science_Fair_Vector.jpg',
      dateTime: DateTime(2025, 8, 22, 9, 0),
      targetClasses: '11th - 12th',
    ),
    Notice(
      title: 'Annual Sports Day',
      subtitle: 'Join us on 25th November for a day full of excitement and competition.',
      fileUrl: 'https://static.vecteezy.com/system/resources/previews/001/850/858/non_2x/school-sports-day-vector.jpg',
      dateTime: DateTime(2025, 11, 10, 15, 45),
      targetClasses: '8th - 12th',
    ),
    Notice(
      title: 'Holiday Notice - Diwali',
      subtitle: 'School will remain closed from 28th Oct to 3rd Nov for Diwali holidays.',
      fileUrl: 'https://k8school.com/wp-content/uploads/2023/11/Why-Are-Exams-Important-How-Do-They-Improve-Learning.jpg',
      dateTime: DateTime(2025, 10, 20, 12, 15),
      targetClasses: '6th - 12th',
    ),
    Notice(
      title: 'PTM Reminder',
      subtitle: 'Parent-Teacher Meeting is scheduled on 5th September, 10 AM to 1 PM.',
      fileUrl: 'https://static.vecteezy.com/system/resources/thumbnails/000/202/099/small_2x/Science_Fair_Vector.jpg',
      dateTime: DateTime(2025, 9, 3, 16, 20),
      targetClasses: '6th - 10th',
    ),
  ];



  @override
  Future<void> onInit() async {
    selectedDay.value = 'Mon';
    listDays.addAll(days);
    updatePeriods(days[0]);
    super.onInit();
  }

  void updatePeriods(String day){
    listPeriods.clear();
    listPeriods.addAll(timeTable[day] ?? []);
  }

  String formatDate(DateTime dateTime){
    String formattedDate = DateFormat('dd-MMM-yy').format(dateTime);
    return formattedDate;
  }
}