import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:two2/core/models/http_exception.dart';
import 'package:two2/core/view_model/provider/Book.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  
  List<Book> book = [
    Book(
      name: 'السببيةوميكانيكاالكم',
      category: 'كتب علمية',
      price: 25,
      description:
          '''هذا الكتاب يُلقي الضوءَ على قضايا فلسفية وعلمية في غاية الأهمية؛ فهو يقدِّم تحريرًا دقيقًا لمفهوم السببية وعَلاقتها بالعلوم المعاصرة، كما يقدِّم براهينَ صلبة ومتماسكة للاستدلال بالسببية على الخالق، وأثناء ذلك يمر على أهم الشبهات والمعارضات ويفنِّدها جميعًا.
      ثم يَعرض لأسباب وأصول التعارض الشهير بين السببية وميكانيكا الكَمِّ؛ ليظهر بجلاء أن المشكلة لم تكن يومًا بين السببية وميكانيكا الكم، وإنما كانت دائمًا مشكلة الحتمية مع ميكانيكا الكم. والسببيةُ مفهوم منفصل ومستقل تمامًا عن الحتمية.
      وقد آثرتُ الابتعادَ عن التفاصيل الدقيقة التي يصعب على غير المتخصصين الإلمام بها. مع حرصي على دقة التوثيق العلمي، فغالبية المصادر كانت من أوراق علمية مُحكمة حديثة النشر.
      أرجو أن يُغني هذا الكتاب القرَّاءَ عن رحلة بحث طويلة وشائكة خلال الفلسفات المتضاربة حول مفهوم السببية ودلالاته. كما أرجو أن يثير شغَفَهم حول مجالات علمية واعدة وحديثة داخل فيزياء الكم تحتضن السببيةَ وتعتمد على تطبيقاتها.
      وأظن أن الكتاب مناسب للجميع.. وأرجو أن ينتفع به المسلمُ، واللاأدري، والملحد، ومحِبُّو الفلسفة، ومُحبُّو العلوم الفيزيائية والرياضيات، وكلُّ مَن يهتم ويقتطع من وقته شيئًا لقراءة هذا الكتاب. ''',
      imageUrl: 'assets/images/ph0.jpg',
      id: '1',
      quantity: 1000,
    ),
    Book(
      name: 'ابق قويا',
      category: 'كتب تطوير الذات',
      price: 25,
      description: '',
      imageUrl: 'assets/images/ph1.jpg',
      id: '2',
      quantity: 90,
    ),
    Book(
      name: 'رحلتي من الشك الى الايمان',
      category: 'كتب فلسفية',
      price: 25,
      description: 'bhgkgyyigligigigiuuihuihuhuuhuh',
      imageUrl: 'assets/images/ph2.jpg',
      id: '3',
      quantity: 50,
    ),
    Book(
      name: 'ليلى والذئب',
      category: 'كتب أطفال',
      price: 25,
      description: 'hyfgukhilhukgyjftfygbukgu',
      imageUrl: 'assets/images/ph3.jpg',
      id: '4',
      quantity: 25,
    ),
  ];

  late String authtoken;
  late String userid;

//(نستفيد منعا في البروكسي بروفايدر)تابع يقوم بارجاع البيانات
  getdata(String authtok, String uid, List<Book> books) {
    authtoken = authtok;
    userid = uid;
    book = books;
    notifyListeners();
  }

  //تابع استخدمناه لاننا عرفنا المنتجات باريفت
  List<Book> get mybooks {
    return [...book];
  }

  List<Book> get favoritesBooks {
    return book.where((proditem) => proditem.isfavorite).toList();
  }

  Book findbyid(String id) {
    return book.firstWhere((bok) => bok.id == id);
  }

  //تجلب البيانات كم الداتا
  Future<void> fetchandsetbook([bool filterbyuser = false]) async {
    final filterstring =
        filterbyuser ? 'orderBy="creatorId"&equalTo="$userid"' : '';
    var url =
        'https://almorjan-cd066-default-rtdb.firebaseio.com/products.json?auth=$authtoken&$filterstring';
    try {
      final res = await http.get(Uri.parse(url));
      final extractdata = json.decode(res.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return;
      }
      url =
          'https://almorjan-cd066-default-rtdb.firebaseio.com/userfavorites/$userid.json?auth=$authtoken';
      final favres = await http.get(Uri.parse(url));
      final favdata = json.decode(favres.body);
      final List<Book> loadedbooks = [];
      extractdata.forEach((bokid, bokdata) {
        loadedbooks.add(
          Book(
            id: bokid,
            name: bokdata['name'],
            imageUrl: bokdata['imageUrl'],
            quantity: bokdata['quantity'],
            price: bokdata['price'],
            description: bokdata['description'],
            isfavorite: favdata == null ? false : favdata[bokid] ?? false,
            category: 'nutural',
          ),
        );
      });
      book = loadedbooks;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addproduct(Book bok) async {
    final url =
        'https://almorjan-cd066-default-rtdb.firebaseio.com/products.json?auth=$authtoken';
    try {
      //نضيف البيانات الى السيرفر
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'name': bok.name,
            'quantity': bok.quantity,
            'price': bok.price,
            'description': bok.description,
            'creatorId': userid,
            'imageUrl': bok.imageUrl,
          }));
      //عطي البيانات الى item_
      final newbook = Book(
        id: json.decode(res.body)['name'],
        name: bok.name,
        imageUrl: bok.imageUrl,
        quantity: bok.quantity,
        price: bok.price,
        description: bok.description,
        category: 'nutrual',
      );
      book.add(newbook);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateproduct(String id, Book newbook) async {
    final bookindex = book.indexWhere((bok) => bok.id == id);
    if (bookindex >= 0) {
      //العنصر موجود
      final url =
          'https://almorjan-cd066-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'quantity': newbook.quantity,
            'imageUrl': newbook.imageUrl,
            'price': newbook.price,
            'description': newbook.description,
          }));
      book[bookindex] = newbook;
      notifyListeners();
    } else {
      print("....");
    }
  }

  Future<void> deletebook(String id) async {
    final url =
        'https://almorjan-cd066-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken';
    final existingbookindex = book.indexWhere((bok) => bok.id == id);
    Book? existingbook = book[existingbookindex];
    book.removeAt((existingbookindex)); //يقوم بحذف العنصر من التطبيق
    notifyListeners();
    final res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      book.insert(existingbookindex, existingbook);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingbook = null; //
  }

  PageController pageController = PageController();
  int selectedPage = 0;

  onPageChanged(int index) {
    selectedPage = index;
    notifyListeners();
  }

  int get selectedPageNum => selectedPage;

  // int getSelectedPage(){
  //   return selectedPage;
  //   notifyListeners();
  // }

  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  void addtofavorit(Book book) {
    notifyListeners();
  }

  void addtoCart(Book book) {
    notifyListeners();
  }
}
