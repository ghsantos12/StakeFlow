package com.stakeflow.stakeflow

import io.flutter.embedding.android.FlutterFragmentActivity

// local_auth usa a BiometricPrompt do AndroidX, que exige que a Activity
// hospedeira seja uma FragmentActivity — com FlutterActivity (padrão do
// template do Flutter), authenticate() lança uma exceção e o prompt de
// biometria/PIN nunca é exibido.
class MainActivity : FlutterFragmentActivity()
