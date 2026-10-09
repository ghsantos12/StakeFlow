/// Calcula um intervalo (em índice de ponto) que mantém no máximo
/// [targetCount] rótulos visíveis no eixo, evitando que datas/valores se
/// sobreponham em telas estreitas independentemente de quantos pontos a
/// série tiver.
double axisLabelInterval(int pointCount, {int targetCount = 4}) {
  if (pointCount <= targetCount) return 1;
  return (pointCount / targetCount).ceil().toDouble();
}
