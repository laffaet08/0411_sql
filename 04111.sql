-- Banco da central de suporte
CREATE DATABASE suporte_join;
USE suporte_join;
 
-- Técnicos da equipe
CREATE TABLE tecnico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  nivel VARCHAR(5) NOT NULL
);
 
-- Chamados: tecnico_id aponta para tecnico(id)
CREATE TABLE chamado (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(80) NOT NULL,
  prioridade VARCHAR(10) NOT NULL,
  status VARCHAR(15) NOT NULL,
  data_abertura DATE NOT NULL,
  tecnico_id INT NOT NULL,
  FOREIGN KEY (tecnico_id) REFERENCES tecnico(id)
);
 
INSERT INTO tecnico (nome, email, nivel) VALUES
  ('Renata Silva', 'renata.silva@empresa.com.br', 'N1'),
  ('Paulo Gomes', 'paulo.gomes@empresa.com.br', 'N2'),
  ('Aline Torres', 'aline.torres@empresa.com.br', 'N3'),
  ('Marcos Vieira', 'marcos.vieira@empresa.com.br', 'N1');
 
INSERT INTO chamado (titulo, prioridade, status, data_abertura, tecnico_id) VALUES
  ('Impressora não imprime', 'Baixa', 'Resolvido', '2026-10-20', 1),
  ('Sem acesso ao e-mail', 'Média', 'Resolvido', '2026-10-21', 1),
  ('Servidor de arquivos lento', 'Alta', 'Em andamento', '2026-10-22', 2),
  ('VPN não conecta', 'Alta', 'Aberto', '2026-10-23', 2),
  ('Suspeita de phishing', 'Crítica', 'Em andamento', '2026-10-24', 3),
  ('Troca de senha', 'Baixa', 'Resolvido', '2026-10-25', 1),
  ('Backup falhou', 'Crítica', 'Aberto', '2026-10-26', 3),
  ('Instalar software', 'Média', 'Aberto', '2026-10-27', 2);
  
SELECT * FROM tecnico;
SELECT * FROM chamado;

  SELECT chamado.titulo, tecnico.nome
FROM chamado
INNER JOIN tecnico ON chamado.tecnico_id = chamado.id;

  SELECT chamado.titulo, chamado.prioridade 
FROM chamado
INNER JOIN tecnico ON chamado.tecnico_id = chamado.id
WHERE tecnico.nome = 'Aline Torres';

SELECT chamado.titulo, tecnico.nome, chamado.status, tecnico.nivel
FROM chamado
INNER JOIN tecnico
ON chamado.tecnico_id = tecnico.id
WHERE chamado.status = 'Aberto'
AND tecnico.nivel = 'N2';

SELECT chamado.titulo, tecnico.nome, chamado.data_abertura
FROM chamado
INNER JOIN tecnico
ON chamado.tecnico_id = tecnico.id
ORDER BY chamado.data_abertura DESC
LIMIT 3;

SELECT COUNT(*) AS total_resolvidos
FROM chamado
INNER JOIN tecnico
ON chamado.tecnico_id = tecnico.id
WHERE tecnico.nivel = 'N1'
AND chamado.status = 'Resolvido';

SELECT DISTINCT tecnico.nome
FROM chamado
INNER JOIN tecnico
ON chamado.tecnico_id = tecnico.id;

SELECT DISTINCT tecnico.nome
FROM tecnico
LEFT JOIN chamado
ON tecnico.id = chamado.tecnico_id;
