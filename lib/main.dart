import 'package:flutter/material.dart'; // Importa la librería de Material Design

void main() {
  // Ejecuta la aplicación llamando al MaterialApp
  runApp(const MyApp());
}

// Creamos un widget raíz (MaterialApp) que envuelva a tu pantalla
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Registro XYZ', // Título interno
      debugShowCheckedModeBanner: false, // Quita la cinta de "Debug"
      home: FormularioScreen(), // Aquí llamas a tu pantalla principal
    );
  }
}

class FormularioScreen extends StatefulWidget { // Usamos StatefulWidget porque los datos cambian al presionar el botón
  const FormularioScreen({super.key}); // Constructor con super.key

  @override
  State<FormularioScreen> createState() => _FormularioScreenState(); // Crea el estado de la pantalla
}

class _FormularioScreenState extends State<FormularioScreen> {
  // 1. Declaramos los Controladores para cada campo de texto
  final TextEditingController _nombreCtrl = TextEditingController(); // Controlador para el nombre
  final TextEditingController _direccionCtrl = TextEditingController(); // Controlador para la dirección
  final TextEditingController _fechaCtrl = TextEditingController(); // Controlador para la fecha
  final TextEditingController _cargoCtrl = TextEditingController(); // Controlador para el cargo

  // 2. Variable de estado para saber si mostramos los datos o no
  bool _mostrarDatos = false; // Inicia en false (oculto)

  // 3. Liberar los controladores al cerrar la pantalla
  @override
  void dispose() {
    _nombreCtrl.dispose(); // Libera el controlador de nombre
    _direccionCtrl.dispose(); // Libera el controlador de dirección
    _fechaCtrl.dispose(); // Libera el controlador de fecha
    _cargoCtrl.dispose(); // Libera el controlador de cargo
    super.dispose(); // Llama al dispose padre
  }

  // 4. Función que se ejecuta al presionar el botón
  void _mostrarDatosRegistrados() {
    // Verificamos que el nombre no esté vacío (validación mínima)
    if (_nombreCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu nombre completo')), // Muestra alerta
      );
      return; // Detiene la ejecución
    }



    setState(() {
      _mostrarDatos = !_mostrarDatos; // Cambia el estado (si era true, se vuelve false y viceversa)
    });
  }

  // 5. Función auxiliar para crear los campos de texto y no repetir código
  Widget _buildTextField({
    required String label, // Etiqueta del campo
    required String hint, // Texto de ayuda (placeholder)
    required TextEditingController controller, // Controlador del campo
    Widget? suffixIcon, // Ícono opcional a la derecha (para el calendario)
    TextInputType keyboardType = TextInputType.text, // Tipo de teclado
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'serif',)), // Texto de la etiqueta
        const SizedBox(height: 5), // Espacio entre etiqueta y campo
        TextField(
          controller: controller, // Asigna el controlador
          keyboardType: keyboardType, // Tipo de teclado
          decoration: InputDecoration(
            hintText: hint, // Texto de ayuda
            hintStyle: const TextStyle(color: Colors.black38), // Color del texto de ayuda
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), // Relleno interno
            border: OutlineInputBorder( // Borde redondeado
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder( // Borde cuando no está seleccionado
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: suffixIcon, // Pone el ícono si se lo pasamos
          ),
        ),
        const SizedBox(height: 15), // Espacio después de cada campo
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Color de fondo gris claro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E6F45), // Color verde oscuro de la imagen
        foregroundColor: Colors.white, // Texto blanco
        title: const Text('Empresa XYZ · Registro', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'serif')), // Título del AppBar
      ),
      body: SingleChildScrollView( // Permite hacer scroll si la pantalla es pequeña
        padding: const EdgeInsets.all(16.0), // Margen exterior
        child: Container(
          padding: const EdgeInsets.all(20), // Relleno dentro de la tarjeta blanca
          decoration: BoxDecoration( // Decoración de la tarjeta blanca principal
            color: Colors.white, // Fondo blanco
            borderRadius: BorderRadius.circular(12), // Bordes redondeados
            border: Border.all(color: Colors.grey[300]!), // Borde gris claro
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Estira los elementos
            children: [
              // --- CAMPOS DEL FORMULARIO ---
              _buildTextField(
                label: 'Nombre completo',
                hint: 'Ej.: Ana María Pérez López',
                controller: _nombreCtrl,
              ),
              _buildTextField(
                label: 'Dirección',
                hint: 'Ej.: Av. 25 de Julio y Pío Jaramillo',
                controller: _direccionCtrl,
              ),
              _buildTextField(
                label: 'Fecha de nacimiento',
                hint: 'dd/mm/aaaa',
                controller: _fechaCtrl,
                keyboardType: TextInputType.datetime, // Teclado numérico
                suffixIcon: const Icon(Icons.calendar_month, color: Colors.lightGreen), // Ícono de calendario
              ),
              _buildTextField(
                label: 'Cargo',
                hint: 'Ej.: Asistente administrativo',
                controller: _cargoCtrl,
              ),

              const SizedBox(height: 10), // Espacio antes del botón

              // --- BOTÓN MOSTRAR DATOS ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E6F45), // Verde oscuro
                  foregroundColor: Colors.white, // Texto blanco
                  padding: const EdgeInsets.symmetric(vertical: 16), // Botón alto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  ),
                ),
                onPressed: _mostrarDatosRegistrados, // Llama a la función
                child: const Text(
                  'MOSTRAR DATOS',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'serif'),
                ),
              ),

              const SizedBox(height: 20), // Espacio antes del recuadro de resultados


              Container(
                width: double.infinity, // Ocupa todo el ancho
                padding: const EdgeInsets.all(16), // Relleno interior
                decoration: BoxDecoration(
                  color: _mostrarDatos ? const Color(0xFFE8F5E9) : Colors.transparent, // Verde muy claro si se muestran, sino transparente
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  border: Border.all(
                    color: _mostrarDatos ? const Color(0xFF1E6F45) : Colors.grey[300]!, // Borde verde si se muestran, sino gris
                  ),
                ),
                child: _mostrarDatos
                    ? Column( // Si _mostrarDatos es true, muestra los datos
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DATOS REGISTRADOS',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E6F45), fontFamily: 'serif'),
                    ),
                    const SizedBox(height: 10),
                    Text('Nombre: ${_nombreCtrl.text}'), // Imprime el nombre
                    Text('Dirección: ${_direccionCtrl.text}'), // Imprime la dirección
                    Text('Nacimiento: ${_fechaCtrl.text} - Cargo: ${_cargoCtrl.text}'), // Imprime fecha y cargo
                  ],
                )
                    : const Text( // Si es false, muestra el texto gris de la imagen 1
                  'Aquí se mostrarán los datos\nal presionar el botón',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black38, fontFamily: 'serif'),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}