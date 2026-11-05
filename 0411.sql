-- Banco do registro de acessos
CREATE DATABASE seguranca_join;
USE seguranca_join;
 
-- Usuários do sistema
CREATE TABLE usuario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  login VARCHAR(30) NOT NULL UNIQUE,
  nome VARCHAR(60) NOT NULL,
  setor VARCHAR(30) NOT NULL
);
 
-- Tentativas de login: usuario_id aponta para usuario(id)
CREATE TABLE acesso (
  id INT AUTO_INCREMENT PRIMARY KEY,
  data_hora DATETIME NOT NULL,
  ip VARCHAR(15) NOT NULL,
  resultado VARCHAR(10) NOT NULL,
  usuario_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);
 
INSERT INTO usuario (login, nome, setor) VALUES
  ('mcosta', 'Mariana Costa', 'TI'),
  ('rmendes', 'Rafael Mendes', 'TI'),
  ('jprado', 'Juliana Prado', 'RH'),
  ('tramos', 'Thiago Ramos', 'Financeiro'),
  ('aalves', 'Ana Alves', 'Financeiro');
 
INSERT INTO acesso (data_hora, ip, resultado, usuario_id) VALUES
  ('2026-10-27 08:02:10', '192.168.0.15', 'Sucesso', 1),
  ('2026-10-27 08:15:44', '192.168.0.22', 'Sucesso', 3),
  ('2026-10-27 09:01:03', '203.0.113.50', 'Falha', 4),
  ('2026-10-27 09:01:20', '203.0.113.50', 'Falha', 4),
  ('2026-10-27 09:01:41', '203.0.113.50', 'Falha', 4),
  ('2026-10-27 09:30:12', '192.168.0.31', 'Sucesso', 2),
  ('2026-10-27 22:47:05', '198.51.100.7', 'Falha', 1),
  ('2026-10-27 22:47:30', '198.51.100.7', 'Sucesso', 1);

SELECT acesso.data_hora, usuario.login, acesso.resultado
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id;

SELECT acesso.data_hora, acesso.ip, acesso.resultado
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id
WHERE usuario.nome = 'Mariana Costa';

SELECT usuario.login, usuario.setor, acesso.ip, acesso.resultado
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id
WHERE acesso.resultado = 'Falha'
AND usuario.setor = 'TI';

SELECT usuario.login, acesso.ip, acesso.data_hora
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id
ORDER BY acesso.data_hora DESC
LIMIT 3;

SELECT COUNT(*) AS total_falhas
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id
WHERE usuario.setor = 'Financeiro'
AND acesso.resultado = 'Falha';

SELECT DISTINCT usuario.login
FROM acesso
INNER JOIN usuario
ON acesso.usuario_id = usuario.id;

SELECT usuario.login
FROM usuario
LEFT JOIN acesso
ON usuario.id = acesso.usuario_id;