import UIKit

// Definición de la estructura Restaurant
struct Restaurant {
    let nombre: String
    let tipo: String
    let imagenNombre: String
}

// Lista de restaurantes
let cadena = [
    Restaurant(nombre: "Foster", tipo: "Auténtica comida americana con una variedad de hamburguesas y platos clásicos.", imagenNombre: "americana.jpg"),
    Restaurant(nombre: "Ginos", tipo: "Experimenta la auténtica cocina italiana con nuestras pastas y pizzas frescas.", imagenNombre: "italiana.jpg"),
    Restaurant(nombre: "La Andaluza", tipo: "Disfruta de la esencia de la cocina española con tapas y platos tradicionales.", imagenNombre: "espanola.jpg"),
    Restaurant(nombre: "Sushi House", tipo: "Delicioso sushi y platos japoneses preparados con ingredientes frescos.", imagenNombre: "shushi.jpg"),
    Restaurant(nombre: "Taco Haven", tipo: "Saborea auténticos tacos mexicanos y otros platillos tradicionales.", imagenNombre: "tacos.jpg"),
    Restaurant(nombre: "Mediterráneo Delight", tipo: "Explora la rica cocina mediterránea con sabores frescos y saludables.", imagenNombre: "mediterraneo.jpg"),
    Restaurant(nombre: "Thai Spice", tipo: "Prueba la auténtica cocina tailandesa con platos picantes y aromáticos.", imagenNombre: "thai.jpg"),
    Restaurant(nombre: "Burger Bistro", tipo: "Crea tu propia experiencia de hamburguesa gourmet con opciones personalizadas.", imagenNombre: "burgers.jpg"),
    Restaurant(nombre: "Sweet Treats Café", tipo: "Disfruta de postres y dulces deliciosos en un ambiente acogedor.", imagenNombre: "desserts.jpg"),
    Restaurant(nombre: "Vegetarian Oasis", tipo: "Explora opciones vegetarianas y veganas llenas de sabor y nutrición.", imagenNombre: "vegetarian.jpg"),
]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // TableView para mostrar la lista de restaurantes
    private let restaurantsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Variable para almacenar el restaurante seleccionado
    private var selectedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración de la pantalla principal
        view.backgroundColor = .systemGray2
        restaurantsTableView.dataSource = self
        restaurantsTableView.delegate = self
        restaurantsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        view.addSubview(restaurantsTableView)
        
        // Restricciones para centrar la tabla en la pantalla
        NSLayoutConstraint.activate([
            restaurantsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restaurantsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            restaurantsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // Ancho del 80% de la pantalla
            restaurantsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6), // Alto del 60% de la pantalla
        ])
    }
    
    // Función para determinar el número de filas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cadena.count
    }
    
    // Función para configurar las celdas de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let model = cadena[indexPath.row]
        
        // Asigna el texto del tipo a la celda
        cell.textLabel?.text = model.nombre
     
        return cell
    }
    
    // Función que se ejecuta al seleccionar una fila
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = cadena[indexPath.row]
        selectedRestaurant = model // Almacena el restaurante seleccionado
        
        // Muestra la imagen en una pantalla modal
        let imageViewController = ImageViewController()
        imageViewController.modalPresentationStyle = .overFullScreen
        imageViewController.restaurant = model // Pasa el restaurante a la pantalla modal
        present(imageViewController, animated: true, completion: nil)
    }
}

class ImageViewController: UIViewController {
    
    // Variable para recibir el restaurante desde la pantalla principal
    var restaurant: Restaurant?
    
    // ImageView para mostrar la imagen del restaurante
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Label para mostrar el tipo del restaurante
    private let typeLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.numberOfLines = 0 // Permite múltiples líneas
         label.lineBreakMode = .byWordWrapping // Envuelve el texto según sea necesario
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración de la pantalla modal
        view.backgroundColor = .systemGray2

        // Configura la imagen del restaurante
        if let imageName = restaurant?.imagenNombre, let image = UIImage(named: imageName) {
            imageView.image = image
        }
        
        // Configura el tipo del restaurante
        typeLabel.text = restaurant?.tipo
        
        // Agrega la imagen y el tipo a la vista
        view.addSubview(imageView)
        view.addSubview(typeLabel)
        
        // Configura las restricciones
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            
            typeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // Agrega un botón de cierre en la esquina superior derecha
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Cerrar", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    // Función para manejar el toque del botón "Cerrar"
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
