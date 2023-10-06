CREATE SEQUENCE hp_salesperson_seq start with 10000;


CREATE TABLE salesperson (
  salesperson_id bigint NOT NULL DEFAULT nextval('hp_salesperson_seq'),
  first_name varchar(50) DEFAULT NULL,
  last_name varchar(50) DEFAULT NULL,
  email varchar(50) DEFAULT NULL,
  phone varchar(50) DEFAULT NULL,
  address varchar(50) DEFAULT NULL,
  city varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  zipcode varchar(50) DEFAULT NULL,
  PRIMARY KEY (salesperson_id)
);

ALTER SEQUENCE hp_salesperson_seq OWNED BY salesperson.salesperson_id;

INSERT INTO salesperson (salesperson_id, first_name, last_name, email, phone, address, city, state, zipcode)
VALUES
(100,'Jack','Powell','jpowell0@hplussport.com','(434)951-5046','5 Jenifer Crossing','Lynchburg','Virginia','24515'),
(101,'Emily','Garcia','egarcia1@hplussport.com','(603)489-3196','97 Vidon Alley','Manchester','New Hampshire','3105'),
(102,'Richard','Dean','rdean2@hplussport.com','(713)474-6460','2482 1st Road','Houston','Texas','77228'),
(103,'Jane','Porter','jporter3@hplussport.com','(703)355-7761','5230 Rigney Circle','Alexandria','Virginia','22301'),
(104,'Robin','Vasquez','rvasquez4@hplussport.com','(915)388-4102','7 Upham Alley','El Paso','Texas','79984'),
(105,'Douglas','Flores','dflores5@hplussport.com','(832)915-9358','144 Banding Lane','Houston','Texas','77090'),
(106,'Craig','Johnston','cjohnston6@hplussport.com','(505)817-9381','35301 Burning Wood Park','Las Cruces','New Mexico','88006'),
(107,'Norma','Johnson','njohnson7@hplussport.com','(806)598-4321','3011 Mosinee Park','Amarillo','Texas','79188'),
(108,'Kathryn','Bishop','kbishop8@hplussport.com','(540)974-0903','664 Dwight Road','Roanoke','Virginia','24014'),
(109,'Joe','Stewart','jstewart9@hplussport.com','(214)830-4948','2 Sutherland Road','Mesquite','Texas','75185'),
(110,'Dennis','Price','dpricea@hplussport.com','(617)970-2059','73 Homewood Terrace','Lynn','Massachusetts','1905'),
(111,'Jason','Reid','jreidb@hplussport.com','(214)519-1239','3 Derek Hill','Garland','Texas','75049'),
(112,'Randy','Gomez','rgomezc@hplussport.com','(316)400-0352','929 Lindbergh Court','Wichita','Kansas','67260'),
(113,'Jerry','George','jgeorged@hplussport.com','(623)847-6940','03 Comanche Crossing','Phoenix','Arizona','85035'),
(114,'Jane','Larson','jlarsone@hplussport.com','(206)864-1306','20 Nelson Way','Seattle','Washington','98185'),
(115,'Joyce','Carr','jcarrf@hplussport.com','(812)412-4972','26195 Bunting Park','Bloomington','Indiana','47405'),
(116,'James','Ortiz','jortizg@hplussport.com','(405)225-2520','7 Loomis Place','Oklahoma City','Oklahoma','73179'),
(117,'Jimmy','Fowler','jfowlerh@hplussport.com','(904)956-6099','43527 Mendota Trail','Jacksonville','Florida','32225'),
(118,'Benjamin','Sims','bsimsi@hplussport.com','(502)297-0499','42 Johnson Center','Louisville','Kentucky','40298'),
(119,'Jack','Wagner','jwagnerj@hplussport.com','(763)638-7036','175 Montana Way','Monticello','Minnesota','55590'),
(120,'Sharon','Evans','sevansk@hplussport.com','(217)166-8659','544 Anderson Hill','Springfield','Illinois','62764'),
(121,'Tina','Mccoy','tmccoyl@hplussport.com','(408)105-0706','953 Menomonie Street','San Jose','California','95160'),
(122,'Joan','Ruiz','jruizm@hplussport.com','(239)644-8435','82675 Magdeline Street','Fort Myers','Florida','33994'),
(123,'Sara','Cox','scoxn@hplussport.com','(405)134-0937','44 Maryland Trail','Oklahoma City','Oklahoma','73104'),
(124,'Jessica','Alvarez','jalvarezo@hplussport.com','(330)492-7789','9 Heath Street','Akron','Ohio','44310'),
(125,'Amanda','Butler','abutlerp@hplussport.com','(612)143-0680','8840 Mesta Lane','Minneapolis','Minnesota','55436'),
(126,'Louis','Gonzales','lgonzalesq@hplussport.com','(915)638-2376','90197 Lillian Road','El Paso','Texas','88569'),
(127,'Victor','Moore','vmoorer@hplussport.com','(212)727-9093','49676 Hermina Lane','New York City','New York','10275'),
(128,'Harold','Lawson','hlawsons@hplussport.com','(919)242-5069','767 Dawn Trail','Raleigh','North Carolina','27615'),
(129,'Carlos','James','cjamest@hplussport.com','(209)201-9627','744 Messerschmidt Place','Visalia','California','93291'),
(130,'Edward','Kelley','ekelleyu@hplussport.com','(810)900-6624','60321 Jenna Point','Flint','Michigan','48555'),
(131,'Gregory','Wells','gwellsv@hplussport.com','(423)431-1517','03 Ohio Junction','Kingsport','Tennessee','37665'),
(132,'Shirley','Carpenter','scarpenterw@hplussport.com','(805)806-7213','0 Corry Terrace','Van Nuys','California','91406'),
(133,'Virginia','Fowler','vfowlerx@hplussport.com','(801)377-8377','8 Nancy Court','Salt Lake City','Utah','84152'),
(134,'Janet','Harvey','jharveyy@hplussport.com','(765)601-0264','34 Crescent Oaks Parkway','Anderson','Indiana','46015'),
(135,'Diana','Parker','dparkerz@hplussport.com','(334)170-4758','50 Lerdahl Point','Montgomery','Alabama','36119'),
(136,'Sara','Simpson','ssimpson10@hplussport.com','(813)363-9040','6 Donald Terrace','Tampa','Florida','33680'),
(137,'Stephen','Duncan','sduncan11@hplussport.com','(720)343-5328','70376 Loomis Court','Denver','Colorado','80209'),
(138,'Daniel','Myers','dmyers12@hplussport.com','(850)550-0988','59839 Rockefeller Court','Tallahassee','Florida','32314'),
(139,'Beverly','Hamilton','bhamilton13@hplussport.com','(615)430-9574','52 Thierer Alley','Memphis','Tennessee','38104'),
(140,'Tina','Holmes','tholmes14@hplussport.com','(206)989-3304','259 Oakridge Park','Seattle','Washington','98127'),
(141,'Bobby','Garcia','bgarcia15@hplussport.com','(757)140-9750','26 Roxbury Alley','Norfolk','Virginia','23504'),
(142,'Wanda','Bennett','wbennett16@hplussport.com','(330)619-7187','77 Northwestern Court','Warren','Ohio','44485'),
(143,'Steven','Johnson','sjohnson17@hplussport.com','(763)227-9040','1 Stoughton Trail','Monticello','Minnesota','55590'),
(144,'Marie','Hall','mhall18@hplussport.com','(234)642-1439','30684 Sundown Street','Canton','Ohio','44760'),
(145,'Wanda','Evans','wevans19@hplussport.com','(214)853-2926','46207 Grayhawk Hill','Dallas','Texas','75221'),
(146,'Nancy','Wagner','nwagner1a@hplussport.com','(203)665-1411','6743 Jana Pass','Waterbury','Connecticut','6726'),
(147,'Roger','Sullivan','rsullivan1b@hplussport.com','(205)638-5220','9440 Mesta Road','Birmingham','Alabama','35254'),
(148,'Dorothy','Boyd','dboyd1c@hplussport.com','(913)833-8602','515 Emmet Road','Kansas City','Kansas','66160'),
(149,'Walter','Rivera','wrivera1d@hplussport.com','(210)179-0406','6 Manitowish Terrace','San Antonio','Texas','78265'),
(150,'Teresa','Riley','triley1e@hplussport.com','(651)210-8670','9491 Jana Lane','Saint Paul','Minnesota','55146');