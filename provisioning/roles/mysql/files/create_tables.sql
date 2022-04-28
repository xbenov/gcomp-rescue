create table secret_data(
   data_id INT NOT NULL AUTO_INCREMENT,
   data_codename VARCHAR(20) NOT NULL,
   data_secret VARCHAR(100) NOT NULL,
   data_date DATE,
   PRIMARY KEY ( data_id )
);

create table assets(
   assets_id INT NOT NULL AUTO_INCREMENT,
   assets_name VARCHAR(100) NOT NULL,
   assets_type VARCHAR(40) NOT NULL,
   assets_ip VARCHAR(15),
   assets_date DATE,
   PRIMARY KEY ( assets_id )
);
