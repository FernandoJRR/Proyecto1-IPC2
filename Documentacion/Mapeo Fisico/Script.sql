CREATE USER fernanrod IDENTIFIED BY '0contraSeQueL2';

CREATE DATABASE muebleria_mimuebleria;

GRANT ALL PRIVILEGES ON muebleria_mimuebleria.* TO fernanrod;

CREATE TABLE modelo_mueble(
nombre VARCHAR(250) NOT NULL PRIMARY KEY,
precio_default FLOAT NOT NULL
);

CREATE TABLE instrucciones_mueble(
nombre_mueble VARCHAR(250) NOT NULL,
tipo_pieza VARCHAR(250) NOT NULL,
cantidad_pieza INT NOT NULL,
CONSTRAINT FK_nombre_modelo FOREIGN KEY (nombre_mueble) REFERENCES modelo_mueble(nombre) ON UPDATE CASCADE,
CONSTRAINT PRIMARY KEY (nombre_mueble, tipo_pieza)
);

CREATE TABLE usuario(
username VARCHAR(200) NOT NULL PRIMARY KEY,
password VARCHAR(200) NOT NULL,
estado ENUM('ACTIVO','CANCELADO') NOT NULL DEFAULT 'ACTIVO',
tipo_usuario ENUM('FABRICA','VENTAS','FINANZAS') NOT NULL
);

CREATE TABLE mueble(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nombre_mueble VARCHAR(250) NOT NULL,
precio_venta FLOAT NOT NULL,
usuario_ensamblador VARCHAR(200),
fecha_ensamble DATE NOT NULL,
CONSTRAINT FK_mueble_nombre FOREIGN KEY(nombre_mueble) REFERENCES modelo_mueble(nombre) ON UPDATE CASCADE ON DELETE NO ACTION,
CONSTRAINT FK_mueble_usuario FOREIGN KEY(usuario_ensamblador) REFERENCES usuario(username) ON DELETE SET NULL
);

CREATE TABLE pieza_de_madera(
id INT AUTO_INCREMENT NOT NULL,
nombre VARCHAR(250) NOT NULL,
costo FLOAT NOT NULL,
mueble INT,
CONSTRAINT PRIMARY KEY(id,nombre,costo),
CONSTRAINT FK_pieza_mueble FOREIGN KEY(mueble) REFERENCES mueble(id) ON DELETE SET NULL
);

CREATE TABLE cliente(
nit VARCHAR(30) NOT NULL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(100) NOT NULL,
municipio VARCHAR(150),
departamento VARCHAR(150)
);

CREATE TABLE factura(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
cliente VARCHAR(30) NOT NULL,
encargado VARCHAR(200) NOT NULL,
fecha DATE NOT NULL,
CONSTRAINT FK_factura_cliente FOREIGN KEY (cliente) REFERENCES cliente(nit),
CONSTRAINT FK_factura_encargado FOREIGN KEY (encargado) REFERENCES usuario(username)
);

CREATE TABLE comprobante_devolucion(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
cliente VARCHAR(30) NOT NULL,
encargado VARCHAR(200) NOT NULL,
fecha DATE NOT NULL,
CONSTRAINT FK_devolucion_cliente FOREIGN KEY (cliente) REFERENCES cliente(nit),
CONSTRAINT FK_devolucion_encargado FOREIGN KEY (encargado) REFERENCES usuario(username)
);

CREATE TABLE compra(
factura INT NOT NULL,
mueble_comprado INT NOT NULL,
precio FLOAT NOT NULL,
nombre_mueble VARCHAR(250) NOT NULL,
CONSTRAINT PRIMARY KEY (factura,mueble_comprado),
CONSTRAINT FK_compra_factura FOREIGN KEY (factura) REFERENCES factura(id),
CONSTRAINT FK_compra_mueble FOREIGN KEY (mueble_comprado) REFERENCES mueble(id),
CONSTRAINT FK_nombre_compra FOREIGN KEY (nombre_mueble) REFERENCES mueble(nombre_mueble)
);

CREATE TABLE devolucion(
comprobante INT NOT NULL,
mueble_devuelto INT NOT NULL,
precio FLOAT NOT NULL,
nombre_mueble VARCHAR(250) NOT NULL,
CONSTRAINT PRIMARY KEY (comprobante,mueble_devuelto),
CONSTRAINT FK_devolucion_comprobante FOREIGN KEY (comprobante) REFERENCES comprobante_devolucion(id),
CONSTRAINT FK_devolucion_mueble FOREIGN KEY (mueble_devuelto) REFERENCES mueble(id),
CONSTRAINT FK_nombre_mueble FOREIGN KEY (nombre_mueble) REFERENCES mueble(nombre_mueble)
);

CREATE TABLE ultimas_lineas_cargadas(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
expresion LONGTEXT NOT NULL
);

CREATE TABLE ultimos_errores(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
expresion LONGTEXT NOT NULL,
error VARCHAR(254) NOT NULL
);

INSERT INTO usuario(username,password,tipo_usuario) VALUES ('admin01','123456','FINANZAS');
