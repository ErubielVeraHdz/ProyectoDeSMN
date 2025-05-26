import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/providers/provider_dias.dart';
import 'package:smn/providers/provider_municipio.dart';
import 'package:smn/utils/favoritos.dart';

class PaginaFavoritos extends StatefulWidget {
  const PaginaFavoritos({super.key});

  @override
  State<PaginaFavoritos> createState() => _PaginaFavoritosState();
}

class _PaginaFavoritosState extends State<PaginaFavoritos> {
  List<ModeloMunicipio> favoritos = [];

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }

  Future<void> _cargarFavoritos() async {
    final lista = await Favoritos.obtenerFavoritos();
    setState(() {
      favoritos = lista;
    });
  }

  Future<void> _eliminarFavorito(ModeloMunicipio municipio) async {
    await Favoritos.eliminarDeFavoritos(municipio.idEdo, municipio.idMpo);
    _cargarFavoritos();
  }

  Future<void> _seleccionarMunicipio(ModeloMunicipio municipio) async {
    final providerMunicipio =
        Provider.of<ProviderMunicipio>(context, listen: false);

    await providerMunicipio.cargarMunicipioDesdeFavoritos(
      context,
      municipio.idEdo,
      municipio.idMpo,
      municipio.label,
    );

    Navigator.pop(context); // Cierra la pantalla de favoritos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.amber,
      ),
      body: favoritos.isEmpty
          ? const Center(child: Text('No hay municipios favoritos'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final municipio = favoritos[index];
                return ListTile(
                  title: Text(municipio.label),
                  leading: const Icon(Icons.location_city),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _eliminarFavorito(municipio),
                  ),
                  onTap: () => _seleccionarMunicipio(municipio),
                );
              },
            ),
    );
  }
}
