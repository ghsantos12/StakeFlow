import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/// Repositório GitHub consultado para checar novas versões publicadas
/// (ver .github/workflows/release.yml, que cria uma release com o APK
/// toda vez que a versão em pubspec.yaml muda e é enviada para main).
const String kUpdateRepoOwner = 'ghsantos12';
const String kUpdateRepoName = 'StakeFlow';

class AppUpdateInfo {
  const AppUpdateInfo({
    required this.version,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.releaseUrl,
  });

  final String version;
  final String releaseNotes;
  final String downloadUrl;
  final String releaseUrl;
}

/// Verifica se há uma versão mais nova publicada nas releases do GitHub.
///
/// É a única parte do app que depende de internet — usada apenas para
/// avisar o usuário sobre atualizações disponíveis, nunca bloqueia nem
/// afeta o funcionamento offline do restante do aplicativo. Qualquer
/// falha (sem internet, API fora do ar, etc.) é silenciosamente ignorada.
class UpdateService {
  UpdateService({
    this.owner = kUpdateRepoOwner,
    this.repo = kUpdateRepoName,
  });

  final String owner;
  final String repo;

  Future<AppUpdateInfo?> checkForUpdate() async {
    try {
      final currentVersion = (await PackageInfo.fromPlatform()).version;

      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
        headers: const {'Accept': 'application/vnd.github+json'},
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final tagName = json['tag_name'] as String? ?? '';
      final remoteVersion = tagName.startsWith('v') ? tagName.substring(1) : tagName;
      if (remoteVersion.isEmpty || !_isNewer(remoteVersion, currentVersion)) {
        return null;
      }

      final assets = (json['assets'] as List?) ?? const [];
      String? apkUrl;
      for (final asset in assets) {
        final name = (asset as Map<String, dynamic>)['name'] as String? ?? '';
        if (name.toLowerCase().endsWith('.apk')) {
          apkUrl = asset['browser_download_url'] as String?;
          break;
        }
      }

      final htmlUrl = json['html_url'] as String? ?? '';
      return AppUpdateInfo(
        version: remoteVersion,
        releaseNotes: (json['body'] as String?)?.trim() ?? '',
        downloadUrl: apkUrl ?? htmlUrl,
        releaseUrl: htmlUrl,
      );
    } catch (_) {
      return null;
    }
  }

  bool _isNewer(String remote, String local) {
    final r = _parseSemVer(remote);
    final l = _parseSemVer(local);
    for (var i = 0; i < 3; i++) {
      if (r[i] != l[i]) return r[i] > l[i];
    }
    return false;
  }

  List<int> _parseSemVer(String version) {
    final core = version.split('+').first;
    final parts = core.split('.');
    return List.generate(3, (i) => i < parts.length ? (int.tryParse(parts[i]) ?? 0) : 0);
  }
}
