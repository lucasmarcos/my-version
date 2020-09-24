DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS terra_forragem;
DROP TABLE IF EXISTS tipo_forragem;
DROP TABLE IF EXISTS proprietario;
DROP TABLE IF EXISTS parto;
DROP TABLE IF EXISTS compra_animal;
DROP TABLE IF EXISTS venda_animal;
DROP TABLE IF EXISTS prenhez;
DROP TABLE IF EXISTS inseminacao;
DROP TABLE IF EXISTS mastite;
DROP TABLE IF EXISTS tratamento;
DROP TABLE IF EXISTS doenca;
DROP TABLE IF EXISTS medicamento;
DROP TABLE IF EXISTS propriedade;
DROP TABLE IF EXISTS info_propriedade;
DROP TABLE IF EXISTS propriedade_tecnico;
DROP TABLE IF EXISTS tecnico;
DROP TABLE IF EXISTS animal;

CREATE TABLE usuario (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(64),
	cidade VARCHAR(64),
	bairro VARCHAR(64),
	numero VARCHAR(64),
	cep CHAR(9), -- 12345-789
	telefone VARCHAR(15), -- +55 046 999 000 444
	email VARCHAR(64),
	tipo VARCHAR(64),
	verificado BOOLEAN,
	senha_hash CHAR(128),
	senha_salt CHAR(128)
);

CREATE TABLE tecnico (
	id SERIAL PRIMARY KEY,
	ano_formatura DATE,
	tipo_registro VARCHAR(32),
	registro_profissional VARCHAR(32)
);

CREATE TABLE proprietario (
	id SERIAL PRIMARY KEY,
	cnpj CHAR(14) -- 1234-6789/1234
);

CREATE TABLE propriedade (
	id SERIAL PRIMARY KEY,
	proprietario INTEGER,
	nome VARCHAR(64),
	longitute REAL,
	latitude REAL,
	data_inicio DATE,
	data_proxima DATE,
	FOREIGN KEY (proprietario) REFERENCES proprietario(id)
);

CREATE TABLE propriedade_tecnico (
	id SERIAL PRIMARY KEY,
	propriedade INTEGER,
	tecnico INTEGER,
	FOREIGN KEY (propriedade) REFERENCES propriedade(id),
	FOREIGN KEY (tecnico) REFERENCES tecnico(id)
);

CREATE TABLE info_propriedade (
	id SERIAL PRIMARY KEY,
	propriedade_tecnico INTEGER,
	insercao DATE,
	pessoas_envolvidas INTEGER,
	area_total REAL,
	area_bovinucultura_leiteira REAL,
	area_pasto_perene REAL,
	area_lavoura_verao REAL,
	area_lavoura_inverno REAL,
	total_terra_arrenada REAL,
	preco_media_terra_nua REAL,
	valor_media_arrendamento REAL,
	-- mapa_uso_solo text,
	FOREIGN KEY (propriedade_tecnico) REFERENCES propriedade_tecnico(id)
);

CREATE TABLE tipo_forragem (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(32),
	tipo VARCHAR(32)
);

CREATE TABLE terra_forragem (
	id SERIAL PRIMARY KEY,
	tipo_forragem INTEGER,
	info_propriedade INTEGER,
	data_formacao DATE,
	area_ha REAL,
	tipo_terra VARCHAR(32),
	custo_medio_formacao REAL,
	vida_util REAL,
	observacao VARCHAR(128),
	FOREIGN KEY (tipo_forragem) REFERENCES tipo_forragem(id),
	FOREIGN KEY (info_propriedade) REFERENCES info_propriedade(id)
);

CREATE TABLE animal (
	id SERIAL PRIMARY KEY,
	propriedade INTEGER,
	identificacao VARCHAR(64),
	sexo CHAR(1),
	peso REAL,
	raca VARCHAR(32),
	status VARCHAR(32),
	data_morte DATE,
	causa_morte VARCHAR(256),
	FOREIGN KEY (propriedade) REFERENCES propriedade(id)
);

CREATE TABLE parto (
	id SERIAL PRIMARY KEY,
	mae INTEGER,
	bezerro INTEGER,
	data DATE,
	peso REAL,
	condicao VARCHAR(32),
	FOREIGN KEY (mae) REFERENCES animal(id),
	FOREIGN KEY (bezerro) REFERENCES animal(id)
);

CREATE TABLE compra_animal (
	id SERIAL PRIMARY KEY,
	animal INTEGER,
	data DATE,
	nascimento DATE,
	peso REAL,
	valor REAL,
	FOREIGN KEY (animal) REFERENCES animal(id)
);

CREATE TABLE venda_animal (
	id SERIAL PRIMARY KEY,
	animal INTEGER,
	data DATE,
	motivo VARCHAR(64),
	valor REAL,
	destino VARCHAR(32),
	FOREIGN KEY (animal) REFERENCES animal(id)
);

CREATE TABLE inseminacao (
	id SERIAL PRIMARY KEY,
	touro INTEGER,
	vaca INTEGER,
	data INTEGER,
	FOREIGN KEY (touro) REFERENCES animal(id),
	FOREIGN KEY (vaca) REFERENCES animal(id)
);

CREATE TABLE prenhez (
	id SERIAL PRIMARY KEY,
	vaca INTEGER,
	touro INTEGER,
	inseminacao INTEGER,
	tipo VARCHAR(32),
	data_diagnostico DATE,
	data_prenhez DATE,
	FOREIGN KEY (inseminacao) REFERENCES inseminacao(id),
	FOREIGN KEY (vaca) REFERENCES animal(id),
	FOREIGN KEY (touro) REFERENCES animal(id)
);

CREATE TABLE mastite (
	id SERIAL PRIMARY KEY,
	animal INTEGER,
	data DATE,
	tipo VARCHAR(32),
	anterior_direita VARCHAR(64),
	anterior_esquerda VARCHAR(64),
	posterior_diretira VARCHAR(64),
	posterior_esquerda VARCHAR(64),
	FOREIGN KEY (animal) REFERENCES animal(id)
);

CREATE TABLE medicamento (
	id SERIAL PRIMARY KEY,
	principio_ativo VARCHAR(32),
	nome VARCHAR(32),
	forma_de_aplicacao VARCHAR(32)
);

CREATE TABLE tratamento (
	id SERIAL PRIMARY KEY,
	animal INTEGER,
	medicamento INTEGER,
	data DATE,
	dose REAL,
	FOREIGN KEY (animal) REFERENCES animal(id),
	FOREIGN KEY (medicamento) REFERENCES medicamento(id)
);

CREATE TABLE doenca (
	id SERIAL PRIMARY KEY,
	animal INTEGER,
	data_diagnostico DATE,
	diagnostico VARCHAR(256),
	FOREIGN KEY (animal) REFERENCES animal(id)
);
