package com.stakeflow.stakeflow

import android.app.ActivityManager
import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

// local_auth usa a BiometricPrompt do AndroidX, que exige que a Activity
// hospedeira seja uma FragmentActivity — com FlutterActivity (padrão do
// template do Flutter), authenticate() lança uma exceção e o prompt de
// biometria/PIN nunca é exibido.
class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        closeOtherInstances()
    }

    // Depois de instalar uma atualização (fora da Play Store, baixando o
    // APK e abrindo pelo instalador do sistema), o Android às vezes deixa
    // uma tarefa antiga do app parada em segundo plano em vez de encerrá-la
    // junto com a atualização — o que parece uma segunda instância do app
    // ao reabrir. singleTask evita duplicar a tela, mas não limpa uma
    // tarefa antiga que já não tem mais essa Activity no topo. Aqui, toda
    // vez que esta Activity é criada, fecha qualquer outra tarefa deste
    // mesmo app que não seja a atual.
    private fun closeOtherInstances() {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager ?: return
        val currentTaskId = taskId
        for (task in activityManager.appTasks) {
            val info = task.taskInfo ?: continue
            if (info.id != currentTaskId) {
                task.finishAndRemoveTask()
            }
        }
    }
}
