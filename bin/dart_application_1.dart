import 'package:http/http.dart' as http;
//import 'dart:async';
import 'dart:convert';

void main() async {
  // URL de la película 'Return of the Jedi'
  String url = 'https://swapi.dev/api/films/3';

  // Obtención de los datos de la película
  String respuesta = await get(url);
  Map mapPelicula = jsonDecode(respuesta);

  // Título y fecha de lanzamiento de la película
  print('Título: ${mapPelicula['title']}');
  print('Fecha lanzamiento: ${mapPelicula['release_date']}');

  // Naves espaciales que aparecen en la película
  print('Naves:');
  mapPelicula['starships'].forEach((element) async {
    // Consulta de los datos de la nave
    String urlNave = '${element}';
    //print('URL: $urlNave');
    String resNave = await get(urlNave);
    Map mapNave = jsonDecode(resNave);
    // Impresión del nombre de la nave
    print('  ${mapNave['name']}');
  });
}

// Función para obtener datos de una URL
Future<String> get(String url) async {
  // Solicitud HTTP
  var response = await http.get(Uri.parse(url));

  // Comprobación de errores
  if (response.statusCode != 200) {
    throw Exception('Error al obtener los datos');
  }

  // Devolución de la respuesta
  return response.body;
}
