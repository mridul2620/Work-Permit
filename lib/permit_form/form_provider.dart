// ignore_for_file: unused_field
import "dart:convert";
import "dart:io";
import 'package:dio/dio.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter/material.dart";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:work_permit/globalvarialbles.dart";
import "package:work_permit/permit_form/Question_model.dart";
import "../home/homepage.dart";

class FormStateProvider with ChangeNotifier {
  String latitude = "";
  String longitude = "";
  String address = "";
  String location = "";
  String dateTime = "";
  File? selfieImage;
  File? certificate;
  File? thirdImage;
  File? fourthImage;
  bool selfie = false;
  bool experience = false;
  late SharedPreferences prefs;
  bool dataLoad = false;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController contractorName = TextEditingController();
  TextEditingController workersController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController additionalDetailsController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String name = '';
  String email = '';
  String number = '';
  bool isLoading = true;
  bool button = false;
  DateTime selectedDate = DateTime.now();
  final dio = Dio();
  List<QuestionLists> questionList = [];
  List<TextEditingController>? remarksControllers;
  //final isTitleValid = title.text.isNotEmpty;

  void updateAnswer(int index, bool? answer) {
    questionList[index].answer = answer;
    notifyListeners();
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await getaddress(position);
    return position;
  }

  Future<void> getaddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    notifyListeners();
  }

  Future<void> getCurrentDateTime() async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    dateTime = formatter.format(now).toString();
    notifyListeners();
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      selfieImage = File(pickedImage.path);
      selfie = true;
      notifyListeners();
    }
  }

  Future<void> getCertificate() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      certificate = File(pickedImage.path);
      experience = true;
    }
    notifyListeners();
  }

  Future<void> image3() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      thirdImage = File(pickedImage.path);
      experience = true;
    }
    notifyListeners();
  }

  Future<void> image4() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      fourthImage = File(pickedImage.path);
      experience = true;
    }
    notifyListeners();
  }

  Future<void> loadUserData() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    number = prefs.getString('mobile') ?? '';
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        startDateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year} ${pickedTime.format(context)}";
        notifyListeners();
      }
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        endDateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year} ${pickedTime.format(context)}";
        notifyListeners();
      }
    }
  }

  Future<void> sendFormData(String permitId, BuildContext context,
      List<Map<String, dynamic>> answersList, String additionalDetails) async {
    dataLoad = true;
    notifyListeners();
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(baseAPI + sendPermit),
    );
    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['title'] = title.text;
    request.fields['description'] = desc.text;
    request.fields['category_id'] = permitId;
    request.fields['location'] = locationController.text;
    request.fields['contractor_name'] = contractorName.text;
    request.fields['no_of_workers'] = workersController.text;
    request.fields['valid_from'] = startDateController.text;
    request.fields['valid_till'] = endDateController.text;
    // request.fields['a']

    request.files.add(await http.MultipartFile.fromPath(
      'selfie_image',
      selfieImage!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'experience_image',
      certificate!.path,
    ));

    // Convert the answers list to a JSON string
    String answersJson = jsonEncode(answersList);

    // Add the answers data to the request
    request.fields['answers'] = answersJson;
    //request.fields['remark'] = answersJson;
    print(request.fields);

    try {
      final response = await request.send();
      final jsonData = await response.stream.bytesToString();

      print(jsonData);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            'Form Sent Successfully',
            style: GoogleFonts.secularOne(fontSize: 13),
          ),
          duration: const Duration(seconds: 3),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        resetValues();
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Message: $e');
    }
  }

  Future<void> sendExtensionFormData(
      String permitId,
      BuildContext context,
      List<Map<String, dynamic>> answersList,
      String extensionReason,
      String additionalDetails) async {
    dataLoad = true;
    notifyListeners();
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(baseAPI + extensionAPI),
    );
    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['permit_id'] = permitId;
    request.fields['reason'] = extensionReason;
    request.fields['valid_from'] = startDateController.text;
    request.fields['valid_till'] = endDateController.text;

    // Convert the answers list to a JSON string
    String answersJson = jsonEncode(answersList);

    // Add the answers data to the request
    request.fields['answers'] = answersJson;
    //request.fields['remark'] = answersJson;
    print(request.fields);

    try {
      final response = await request.send();
      //final jsonData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            'Form Sent Successfully',
            style: GoogleFonts.secularOne(fontSize: 13),
          ),
          duration: const Duration(seconds: 3),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        resetValues();
        dataLoad = false;
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}');
        dataLoad = false;
        notifyListeners();
      }
    } catch (e) {
      dataLoad = false;
      notifyListeners();
      print('Error Message: $e');
    }
  }

  Future<void> fetchQues(int permitId) async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    String apiURL = baseAPI + questionAPI + "/" + permitId.toString();
    final response = await dio.get(
      apiURL,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final data = jsonData["data"];
        questionList = List<QuestionLists>.from(data.map((index) {
          return QuestionLists(
              quesId: index['id'] ?? "",
              quesName: index['question_name'] ?? "",
              quesNo: index['question_no'] ?? "");
        }));
        isLoading = false;
        remarksControllers = List.generate(
          questionList.length,
          (index) => TextEditingController(),
        );
        notifyListeners();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print("Error");
    }
  }

  void resetValues() {
    latitude = "";
    longitude = "";
    address = "";
    location = "";
    dateTime = "";
    selfieImage = null;
    certificate = null;
    selfie = false;
    experience = false;
    title.clear();
    desc.clear();
    workersController.clear();
    startDateController.clear();
    endDateController.clear();
    contractorName.clear();
    reasonController.clear();
    additionalDetailsController.clear();
    locationController.clear();
    name = '';
    email = '';
    number = '';
    isLoading = true;
    button = false;
    dataLoad = false;
    questionList = [];
  }
}
