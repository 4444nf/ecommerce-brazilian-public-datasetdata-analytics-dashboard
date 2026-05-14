-- Create a separate states table for normalization
-- Standardize city names

update olist_customers_dataset
set customer_city = INITCAP(customer_city)

create table states (
	id serial primary key,
	state_name varchar(100) not null,
	state_code char(2) not null unique
)

insert into states (state_name, state_code) values
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas', 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO')

alter table olist_customers_dataset
add constraint fk_states
foreign key(customer_state)
references states(state_code)

alter table olist_geolocation_dataset 
add constraint fk_geol_state
foreign key(geolocation_state)
references states(state_code)

alter table olist_sellers_dataset 
add constraint fk_geol_state
foreign key(seller_state)
references states(state_code)