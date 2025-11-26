class WeatherHelper {
  static String generateWeatherRecommendation({
    required double temp,
    required double feelsLike,
    required int pressure,
    required int humidity,
    required String weatherDescription,
    required double pop, // 0.0 - 1.0
  }) {
    final List<String> advice = [];

    // --- 1. Condición principal ---
    final desc = weatherDescription.toLowerCase();

    if (desc.contains("rain") || desc.contains("drizzle")) {
      advice.add("Lleva paraguas, hay lluvias presentes.");
    } else if (desc.contains("thunderstorm")) {
      advice.add(
          "Hay tormentas eléctricas, evita estar en exteriores si no es necesario.");
    } else if (desc.contains("snow")) {
      advice.add("Está nevando, abrígate bien y conduce con precaución.");
    } else if (desc.contains("clear")) {
      advice.add("El cielo está despejado.");
    } else if (desc.contains("cloud")) {
      advice.add("El clima está mayormente nublado.");
    }

    // --- 2. Probabilidad de precipitaciones ---
    if (pop > 0.7) {
      advice.add("Alta probabilidad de lluvia, lleva paraguas.");
    } else if (pop > 0.4) {
      advice.add("Hay probabilidad moderada de lluvia, toma precauciones.");
    } else if (pop > 0.2) {
      advice.add("Ligeras posibilidades de lluvia.");
    }

    // --- 3. Temperatura y sensación térmica ---
    if (feelsLike >= 33) {
      advice.add("Hace bastante calor, mantente hidratado.");
    } else if (feelsLike >= 28) {
      advice.add("El clima es cálido, procura usar ropa ligera.");
    } else if (feelsLike <= 10) {
      advice.add("Hace frío, usa ropa abrigada.");
    } else if (feelsLike <= 5) {
      advice.add("Frío intenso, lleva ropa térmica si sales.");
    }

    // --- 4. Humedad ---
    if (humidity >= 80) {
      advice.add(
          "La humedad es alta, la sensación térmica podría sentirse más pesada.");
    } else if (humidity <= 30) {
      advice.add("El ambiente está seco, hidrátate bien.");
    }

    // --- 5. Presión atmosférica (tendencias de clima) ---
    if (pressure < 1000) {
      advice.add("La presión baja indica clima inestable.");
    } else if (pressure > 1020) {
      advice.add("Presión alta, clima generalmente estable.");
    }

    // --- Ensamblar frase final ---
    // Evitar duplicados y unir de forma natural
    final uniqueAdvice = advice.toSet().toList();

    if (uniqueAdvice.isEmpty) {
      return "El clima es estable. Disfruta tu día.";
    }

    return uniqueAdvice.join(" ");
  }
}
