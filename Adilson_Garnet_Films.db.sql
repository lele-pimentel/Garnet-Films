BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS atores (
    id_ator INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_ator VARCHAR(30),
    data_nascimento DATE,
    nacionalidade VARCHAR(30)
);
CREATE TABLE IF NOT EXISTS diretor (
    id_diretor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_diretor VARCHAR(30) 
);
CREATE TABLE IF NOT EXISTS filme (
    id_filme INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_filme VARCHAR(30),
    ano INTEGER,
    duracao TIME,
    classificacao_idade INTEGER,
    sinopse VARCHAR(500),
    id_genero INTEGER,
    id_diretor INTEGER,
    id_ator INTEGER, 
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (id_diretor) REFERENCES diretor(id_diretor),
    FOREIGN KEY (id_ator) REFERENCES atores(id_ator)
);
CREATE TABLE IF NOT EXISTS genero (
    id_genero INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_genero VARCHAR(30)
);
CREATE TABLE IF NOT EXISTS log_filmes (
    id_log INTEGER PRIMARY KEY AUTOINCREMENT,
    id_filme INTEGER,
    nome_filme_antigo VARCHAR(30),
    nome_filme_novo VARCHAR(30),
    operacao VARCHAR(10) NOT NULL
);
INSERT INTO "atores" ("id_ator","nome_ator","data_nascimento","nacionalidade") VALUES (1,'Robert Pattinson','1986-05-13','Americano'),
 (2,'Kyle MacLachlan','1959-03-27','Americano'),
 (3,'Rumi Hiiragi','1987-08-01','Japonesa'),
 (4,'Jamie Lee Curtis','1958-11-22','Americana'),
 (5,'Uma Thurman','1970-04-29','Americana'),
 (6,'Samantha Robinson','1991-10-19','Americana');
INSERT INTO "diretor" ("id_diretor","nome_diretor") VALUES (1,'Matt Reeves'),
 (2,'David Lynch'),
 (3,'Hayao Miyazaki'),
 (4,'John Carpenter'),
 (5,'Quentin Tarantino'),
 (6,'Anna Biller');
INSERT INTO "filme" ("id_filme","nome_filme","ano","duracao","classificacao_idade","sinopse","id_genero","id_diretor","id_ator") VALUES (1,'Duna',1984,'02:17:00',14,'O filho de uma família noble assume o controle de um planeta desértico que possui a única fonte da substância mais valiosa do universo.',4,2,2),
 (2,'The Batman',2022,'03:00:00',16,'Em seu segundo ano de combate ao crime, o herói descobre a corrupção em Gotham City que se conecta à sua própria família enquanto persegue um assassino em série.',1,1,1),
 (3,'Viagem de Chihiro',2003,'02:07:00',0,'Uma garota de dez anos muda-se para os arredores de uma nova cidade e acaba entrando num world secreto governado por deuses, bruxas e espíritos.',6,3,3),
 (4,'Halloween',1978,'01:31:00',16,'Quinze anos após assassinar sua irmã na noite de Halloween, Michael Myers escapa de um hospital psiquiátrico e retorna à sua cidade natal para perseguir um grupo de adolescentes.',5,4,4),
 (5,'Kill Bill: Volume 1',2003,'01:51:00',18,'Uma ex-assassina conhecida como A Noiva acorda de um coma de quatro anos após ser traída por seu ex-chefe e inicia uma jornada implacável de vingança.',1,5,5),
 (6,'A Bruxa do Amor',2016,'02:00:00',18,'Uma jovem bruxa bonita usa feitiços e poções para fazer com que os homens se apaixonem desesperadamente por ela, mas suas mágicas acabam gerando consequências finais.',7,6,6);
INSERT INTO "genero" ("id_genero","nome_genero") VALUES (1,'Ação'),
 (2,'Comédia'),
 (3,'Drama'),
 (4,'Ficção Científica'),
 (5,'Terror'),
 (6,'Animação'),
 (7,'Romance');
INSERT INTO "log_filmes" ("id_log","id_filme","nome_filme_antigo","nome_filme_novo","operacao") VALUES (1,7,NULL,'Filme Teste Gatilho','INSERIR'),
 (2,7,'Filme Teste Gatilho','Filme Teste Alterado','ATUALIZA'),
 (3,7,'Filme Teste Alterado',NULL,'DELETAR');
CREATE VIEW catalogo AS
SELECT 
    f.id_filme,
    f.nome_filme AS 'TITULO',
    f.ano AS 'ANO',
    f.duracao AS 'DURAÇÃO',
    g.nome_genero AS 'GENERO',
    d.nome_diretor AS 'DIRETORES',
    a.nome_ator AS 'ATORES PRINCIPAIS',
    f.sinopse AS 'SINOPSE'
FROM filme f
INNER JOIN genero g ON f.id_genero = g.id_genero
INNER JOIN diretor d ON f.id_diretor = d.id_diretor
INNER JOIN atores a ON f.id_ator = a.id_ator;
CREATE TRIGGER trg_after_delete_filme
AFTER DELETE ON filme
FOR EACH ROW
BEGIN
    INSERT INTO log_filmes (id_filme, nome_filme_antigo, operacao)
    VALUES (OLD.id_filme, OLD.nome_filme, 'DELETAR');
END;
CREATE TRIGGER trg_after_insert_filme
AFTER INSERT ON filme
FOR EACH ROW
BEGIN
    INSERT INTO log_filmes (id_filme, nome_filme_novo, operacao)
    VALUES (NEW.id_filme, NEW.nome_filme, 'INSERIR');
END;
CREATE TRIGGER trg_after_update_filme
AFTER UPDATE ON filme
FOR EACH ROW
BEGIN
    INSERT INTO log_filmes (id_filme, nome_filme_antigo, nome_filme_novo, operacao)
    VALUES (OLD.id_filme, OLD.nome_filme, NEW.nome_filme, 'ATUALIZA');
END;
CREATE TRIGGER trg_cascade_delete_atores
AFTER DELETE ON atores
FOR EACH ROW
BEGIN
    DELETE FROM filme WHERE id_ator = OLD.id_ator;
END;
CREATE TRIGGER trg_cascade_delete_diretor
AFTER DELETE ON diretor
FOR EACH ROW
BEGIN
    DELETE FROM filme WHERE id_diretor = OLD.id_diretor;
END;
CREATE TRIGGER trg_cascade_delete_genero
AFTER DELETE ON genero
FOR EACH ROW
BEGIN
    DELETE FROM filme WHERE id_genero = OLD.id_genero;
END;
CREATE TRIGGER trg_cascade_update_atores
AFTER UPDATE ON atores
FOR EACH ROW
BEGIN
    UPDATE filme SET id_ator = NEW.id_ator WHERE id_ator = OLD.id_ator;
END;
CREATE TRIGGER trg_cascade_update_diretor
AFTER UPDATE ON diretor
FOR EACH ROW
BEGIN
    UPDATE filme SET id_diretor = NEW.id_diretor WHERE id_diretor = OLD.id_diretor;
END;
CREATE TRIGGER trg_cascade_update_genero
AFTER UPDATE ON genero
FOR EACH ROW
BEGIN
    UPDATE filme SET id_genero = NEW.id_genero WHERE id_genero = OLD.id_genero;
END;
COMMIT;
