
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weather_app/feature/auth/data/auth_data_service/db_helper.dart';
import 'package:weather_app/feature/auth/data/model/user_moder.dart';

class AuthController extends GetxController {

  final DBHelper _dbHelper = DBHelper.getInstance();

  // Loading
  final RxBool isLoginLoading = false.obs;
  final RxBool isSignupLoading = false.obs;

  // Errors
  final RxString loginError = ''.obs;
  final RxString signupError = ''.obs;

  // Login result callback
  Function(bool success)? onLoginResult;
  Function(bool success)? onSignupResult;

  // ─── LOGIN ───────────────────────────
  Future<void> loginUser({
    required String email,
    required String password,
    required Function(bool success) onResult,
  }) async {
    try {
      isLoginLoading.value = true;
      loginError.value = '';

      int result = await _dbHelper.authenticateUser(
        email: email,
        pass: password,
      );

      switch (result) {
        case 1:
          onResult(true); // ✅ Login success - GoRouter navigate karega
          break;
        case 2:
          loginError.value = 'Email registered nahi hai!';
          onResult(false);
          break;
        case 3:
          loginError.value = 'Wrong password!';
          onResult(false);
          break;
        default:
          loginError.value = 'Kuch galat hua!';
          onResult(false);
      }
    } catch (e) {
      loginError.value = 'Error: $e';
      onResult(false);
    } finally {
      isLoginLoading.value = false;
    }
  }

  // ─── SIGNUP ──────────────────────────
  Future<void> signupUser({required String name, required String email, required String mobNo, required String password, required Function(bool success) onResult}) async {
    try {
      isSignupLoading.value = true;
      signupError.value = '';

      UserModel newUser = UserModel(name: name, email: email, mobNo: mobNo, pass: password);

      int result = await _dbHelper.createUser(newUser: newUser);

      switch (result) {
        case 3:
          onResult(true);       //// Signup success
          break;
        case 2:
          signupError.value = 'Email pehle se hi registered hai';
          onResult(false);
          break;
        case 1:
          signupError.value = 'Kuch galat hua';
          onResult(false);
          break;
      }
    } catch (e) {
      signupError.value = 'Error: $e';
      onResult(false);
    } finally {
      isSignupLoading.value = false;
    }
  }
}