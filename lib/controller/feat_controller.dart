import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pasflutter/models/team_model.dart';

class FeatController extends GetxController {
  // Indikator loading (CircularProgressIndicator) selama proses pengambilan data
  final RxBool isLoading = true.obs;

  // Daftar tim English Premier League hasil parsing dari API
  final RxList<Team> teams = <Team>[].obs;

  // Pesan error jika terjadi kendala jaringan
  final RxString errorMessage = ''.obs;

  static const String endpointUrl =
      'https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php?l=English%20Premier%20League';

  @override
  void onInit() {
    super.onInit();
    fetchPremierLeagueTeams();
  }

  Future<void> fetchPremierLeagueTeams() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final Uri uri = Uri.parse(endpointUrl);
      final response =
          await http.get(uri).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final premierLeagueModel = premierLeagueModelFromJson(response.body);
        teams.assignAll(premierLeagueModel.teams);
      } else {
        errorMessage.value =
            'Gagal memuat data tim (Status: ${response.statusCode})';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan koneksi: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
