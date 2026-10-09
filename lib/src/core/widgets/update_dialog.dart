import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/services/update_service.dart';

/// Exibe o modal de "nova versão disponível" com o changelog da release
/// e um botão que abre o download do APK no navegador.
Future<void> showUpdateDialog(BuildContext context, AppUpdateInfo info) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.system_update_alt_outlined),
      title: Text('Nova versão disponível: v${info.version}'),
      content: SingleChildScrollView(
        child: Text(
          info.releaseNotes.isEmpty
              ? 'Uma nova versão do StakeFlow está disponível para download.'
              : info.releaseNotes,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Agora não'),
        ),
        FilledButton.icon(
          onPressed: () async {
            Navigator.of(context).pop();
            final uri = Uri.tryParse(info.downloadUrl);
            if (uri != null) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.download_outlined),
          label: const Text('Baixar atualização'),
        ),
      ],
    ),
  );
}
