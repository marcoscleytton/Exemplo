-- Criar o banco de dados
CREATE DATABASE e_biblioteca;

-- Selecionar o banco de dados
USE e_biblioteca;

-- Criar a tabela de livros
CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano INT NOT NULL
);

-- Inserir alguns dados de exemplo na tabela de livros
INSERT INTO livros (titulo, autor, ano) VALUES ('Livro A', 'Autor A', 2024);
INSERT INTO livros (titulo, autor, ano) VALUES ('Livro B', 'Autor B', 2025);
INSERT INTO livros (titulo, autor, ano) VALUES ('Livro D', 'Autor D', 2026);

-- Desabilitar o autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

-- Executar instruções SQL
INSERT INTO livros (titulo, autor, ano) VALUES ('Livro A', 'Autor A', 2024);

-- Confirmar a transação
COMMIT;

-- Reabilitar o autocommit
SET autocommit = 1;

DELIMITER //

CREATE PROCEDURE AtualizarLivros()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Se ocorrer um erro, realizar ROLLBACK
        ROLLBACK;
    END;

    -- Iniciar a transação
    START TRANSACTION;

    -- Executar instruções SQL
    INSERT INTO livros (titulo, autor, ano) VALUES ('Livro E', 'Autor E', 2024);
    UPDATE livros SET ano = 2026 WHERE titulo = 'Livro F';
    
    -- Confirmar a transação
    COMMIT;
END//

DELIMITER ;

CALL AtualizarLivros();

### CODE 2 ####

-- Desabilitar o autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

-- Executar instruções SQL
INSERT INTO livros (titulo, autor, ano) VALUES ('Livro C', 'Autor C', 2024);
DELETE FROM livros WHERE titulo = 'Livro D';

-- Confirmar a transação
COMMIT;

-- Reabilitar o autocommit
SET autocommit = 1;
