import 'dart:ui';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();
  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "Select Your Language": "اختر اللغة",
    "Arabic": "العربية",
    "English": "الإنجليزية",
    "About Us": "حول التطبيق",
    "Home": "الرئيسية",
    "Settings": "الإعدادات",
    "Home Screen": "الشاشةالرئيسية",
    "Start your journey by creating your card": "ابدأ رحلتك بإنشاء بطاقتك",
    "Create Card": "إنشاء بطاقة",
    "My Profile": "ملفي الشخصي",
    "Edit Profile Information": "تعديل معلومات الملف الشخصي",
    "Edit My Card": "تعديل بطاقتي",
    "Language": "اللغة",
    "Camera": "الكاميرا",
    "Gallery": "المعرض",
    "Pick Image": "اختر الصورة",
    "First Name": "الاسم الأول",
    "Last Name": "الاسم الأخير",
    "Username": "اسم المستخدم",
    "Email": "البريد الإلكتروني",
    "Phone Number": "رقم الهاتف",
    "Nationality": "الجنسية",
    "City": "المدينة",
    "Your information has been saved successfully": "تم حفظ معلوماتك بنجاح",
    "Save": "حفظ",
    "Please enter some text": "الرجاء إدخال نص",
    "Log Out": "تسجيل الخروج",
    "Enter a link": "أدخل رابطًا",
    "Cancel": "إلغاء",
    "QR Code Scanner": "ماسح رمز الاستجابة السريعة",
    "Contact information saved to contacts!":
        "تم حفظ معلومات الاتصال في جهات الاتصال!",
    "Welcome Back!": "مرحبًا بعودتك!",
    "Happy to see you again, enter your account details":
        "نسعد برؤيتك مرة أخرى، قم بإدخال تفاصيل حسابك",
    "Email or Username": "البريد الإلكتروني أو اسم المستخدم",
    "Example@Example.com": "مثال@مثال.كوم",
    "Password": "كلمة المرور",
    "Your Password": "كلمة المرور الخاصة بك",
    "Forgot Password?": "هل نسيت كلمة المرور؟",
    "Login": "تسجيل الدخول",
    "Don’t have an account": "ليس لديك حساب",
    "Sign up Now": "سجل الآن",
    "Login failed, incorrect account information.":
        "فشل تسجيل الدخول، معلومات الحساب غير صحيحة.",
    "Oops, Your email is not verified, Please verify your email":
        "عذرًا، بريدك الإلكتروني غير مُفَعَّل، يرجى تفعيل بريدك الإلكتروني",
    "Invalid Email or Username": "البريد الإلكتروني أو اسم المستخدم غير صالح",
    "There is no record for this email": "لا توجد سجلات لهذا البريد الإلكتروني",
    "Reset password email has been sent":
        "تم إرسال بريد إلكتروني لإعادة تعيين كلمة المرور",
    "An error occurred while logging in.": "حدث خطأ أثناء تسجيل الدخول.",
    "No user found with the provided email/username.":
        "لم يتم العثور على مستخدم بالبريد الإلكتروني/اسم المستخدم المُقدَم.",
    "No links": "لا يوجد روابط",
    "Prefix": "البادئة",
    "Position": "المنصب",
    "Middle Name": "الاسم الأوسط",
    "CompanyName": "اسم الشركة",
    "Choose links to edit": "اختر الروابط للتحرير",
    "Your card information has been saved successfully":
        "تم حفظ معلومات بطاقتك بنجاح",
    "Position: ": "المنصب:  ",
    "name:": "الإسم: ",
    "?": "؟"
  };
  static const Map<String, dynamic> en = {
    "Select Your Language": "Select Your Language",
    "Arabic": "Arabic",
    "English": "English",
    "About Us": "About Us",
    "Home": "Home",
    "Settings": "Settings",
    "Home Screen": "Home Screen",
    "Start your journey by creating your card":
        "Start your journey by creating your card",
    "Create Card": "Create Card",
    "My Profile": "My Profile",
    "Edit Profile Information": "Edit Profile Information",
    "Edit My Card": "Edit My Card",
    "Language": "Language",
    "Camera": "Camera",
    "Gallery": "Gallery",
    "Pick Image": "Pick Image",
    "First Name": "First Name",
    "Last Name": "Last Name",
    "Username": "Username",
    "Email": "Email",
    "Phone Number": "Phone Number",
    "Nationality": "Nationality",
    "City": "City",
    "Your information has been saved successfully":
        "Your information has been saved successfully",
    "Save": "Save",
    "Log Out": "Log Out",
    "Please enter some text": "Please enter some text",
    "Enter a link": "Enter a link",
    "Cancel": "Cancel",
    "QR Code Scanner": "QR Code Scanner",
    "Contact information saved to contacts!":
        "Contact information saved to contacts!",
    "Welcome Back!": "Welcome Back!",
    "Happy to see you again, enter your account details":
        "Happy to see you again, enter your account details",
    "Email or Username": "Email or Username",
    "Example@Example.com": "Example@Example.com",
    "Password": "Password",
    "Your Password": "Your Password",
    "Forgot Password?": "Forgot Password?",
    "Login": "Login",
    "Don’t have an account?": "Don’t have an account?",
    "Sign up Now": "Sign up Now",
    "Login failed, incorrect account information.":
        "Login failed, incorrect account information.",
    "Oops, Your email is not verified, Please verify your email":
        "Oops, Your email is not verified, Please verify your email",
    "Invalid Email or Username": "Invalid Email or Username",
    "There is no record for this email": "There is no record for this email",
    "Reset password email has been sent": "Reset password email has been sent",
    "An error occurred while logging in.":
        "An error occurred while logging in.",
    "No user found with the provided email/username.":
        "No user found with the provided email/username.",
    "No links": "No links",
    "Prefix": "Prefix",
    "Position": "Position",
    "Middle Name": "Middle Name",
    "CompanyName": "CompanyName",
    "Choose links to edit": "Choose links to edit",
    "Your card information has been saved successfully":
        "Your card information has been saved successfully",
    "Position: ": "Position: ",
    "name:": "name:",
    "?": "?"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
