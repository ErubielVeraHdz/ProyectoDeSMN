import 'package:flutter/material.dart';
import 'package:smn/models/modelo_municipio.dart';

class InfoMunicipio extends StatelessWidget {
  final ModeloMunicipio municipio;

  const InfoMunicipio({Key? key, required this.municipio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(municipio.label),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre: ${municipio.label}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("ID Estado: ${municipio.idEdo}"),
            Text("ID Municipio: ${municipio.idMpo}"),
          ],
        ),
      ),
    );
  }
}
