CREATE DATABASE library;
USE library;

CREATE TABLE registerUser (
    cadUser_id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT,
    cadUser_nomeCompleto VARCHAR(50),
    cadUser_nomeSocial VARCHAR(50),
    cadUser_telefone CHAR(11),
    cadUser_email VARCHAR(50),
    cadUser_nomeRua VARCHAR(50),
    cadUser_numeroResidencial CHAR(4),
    cadUser_logradouro VARCHAR(50),
    cadUser_cidade VARCHAR(50),
    cadUser_estado CHAR(2),
    cadUser_CEP CHAR(11)
);

CREATE TABLE statusBooks (
    statusBooks_id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT,
    tipo VARCHAR(50)
);

CREATE TABLE registerBooks (
    cadBooks_id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT,
    cadBooks_tituloLivro VARCHAR(50),
    cadBooks_editora VARCHAR(50),
    cadBooks_anoPublicacao DATE,
    cadBooks_genero VARCHAR(50),
    cadBooks_ISBN CHAR(15),
    cadUser_id INT NOT NULL,
    statusBooks_id INT NOT NULL,
    FOREIGN KEY (statusBooks_id) REFERENCES statusBooks(statusBooks_id),
    FOREIGN KEY (cadUser_id) REFERENCES registerUser(cadUser_id)
);

CREATE TABLE reservsBooks (
    reservsBooks_id INT NOT NULL PRIMARY KEY UNIQUE AUTO_INCREMENT,
    reservsBooks_listaReserva INT,
    reservsBooks_dataReserva DATE,
    cadUser_id INT NOT NULL,
    cadBooks_id INT NOT NULL, 
    FOREIGN KEY (cadUser_id) REFERENCES registerUser(cadUser_id),
    FOREIGN KEY (cadBooks_id) REFERENCES registerBooks(cadBooks_id)
);

-- Registro de Usuario
INSERT INTO registerUser (cadUser_nomeCompleto, cadUser_telefone, cadUser_email, cadUser_nomeRua, cadUser_numeroResidencial, cadUser_logradouro, cadUser_cidade, cadUser_estado, cadUser_CEP)
VALUES ('João Silva', '12345678901', 'joao@email.com', 'Rua A', '123', 'Logradouro A', 'Cidade A', 'SP', '12345678');

INSERT INTO registerUser (cadUser_nomeCompleto, cadUser_nomeSocial, cadUser_telefone, cadUser_email, cadUser_nomeRua, cadUser_numeroResidencial, cadUser_logradouro, cadUser_cidade, cadUser_estado, cadUser_CEP)
VALUES ('Maria Souza', 'Maria', '98765432101', 'maria@email.com', 'Rua B', '456', 'Logradouro B', 'Cidade B', 'RJ', '87654321');

INSERT INTO registerUser (cadUser_nomeCompleto, cadUser_telefone, cadUser_email, cadUser_nomeRua, cadUser_numeroResidencial, cadUser_logradouro, cadUser_cidade, cadUser_estado, cadUser_CEP)
VALUES ('Carlos Oliveira', '11122233344', 'carlos@email.com', 'Rua C', '789', 'Logradouro C', 'Cidade C', 'MG', '98765432');

SELECT * FROM registerUser;
--

-- Registro de Livros
INSERT INTO registerBooks (cadBooks_tituloLivro, cadBooks_editora, cadBooks_anoPublicacao, cadBooks_genero, cadBooks_ISBN, cadUser_id, statusBooks_id)
VALUES ('Aventuras de Sherlock Holmes', 'Editora ABC', '2020-01-15', 'Mistério', '978-3-16-148410-0', 1, 1);

INSERT INTO registerBooks (cadBooks_tituloLivro, cadBooks_editora, cadBooks_anoPublicacao, cadBooks_genero, cadBooks_ISBN, cadUser_id, statusBooks_id)
VALUES ('Dom Casmurro', 'Editora XYZ', '2015-05-20', 'Drama', '978-0-13-398507-0', 2, 1);

INSERT INTO registerBooks (cadBooks_tituloLivro, cadBooks_editora, cadBooks_anoPublicacao, cadBooks_genero, cadBooks_ISBN, cadUser_id, statusBooks_id)
VALUES ('1984', 'Editora DEF', '2018-12-10', 'Ficção Científica', '978-0-452-28423-4', 3, 2);

SELECT * FROM registerBooks;
--

-- Reserva de livros 
INSERT INTO reservsBooks (reservsBooks_listaReserva, reservsBooks_dataReserva, cadUser_id, cadBooks_id)
VALUES (1, '2022-02-01', 1, 1);

INSERT INTO reservsBooks (reservsBooks_listaReserva, reservsBooks_dataReserva, cadUser_id, cadBooks_id)
VALUES (2, '2023-12-01', 2, 3);

SELECT * FROM reservsBooks;
--

-- Status do Livro
INSERT INTO statusBooks(tipo) VALUES ("Disponivel");
INSERT INTO statusBooks(tipo) VALUES ("Indisponivel");
INSERT INTO statusBooks(tipo) VALUES ("Emprestado");
SELECT * FROM statusBooks;

-- 

DELIMITER //
-- Consulta de Registro de Livros
CALL register_the_Books//

CREATE PROCEDURE register_the_Books()
BEGIN
    SELECT
        registerBooks.cadBooks_id AS Id_Livro,
        registerBooks.cadBooks_tituloLivro AS Titulo_do_livro,
        registerBooks.cadBooks_editora AS Editora_do_livro,
        registerBooks.cadBooks_anoPublicacao AS Ano_de_publicacao_do_livro,
        registerBooks.cadBooks_genero AS Genero_do_livro,
        registerBooks.cadBooks_ISBN AS ISBN_do_livro,
        registerBooks.cadUser_id AS Id_Usuario,
        registerBooks.statusBooks_id AS Status_do_livro,
        reservsBooks.reservsBooks_dataReserva AS Data_da_reserva_do_livro
    FROM
        registerBooks
    INNER JOIN
        reservsBooks ON registerBooks.cadBooks_id = reservsBooks.cadBooks_id;
END //


DELIMITER ;








