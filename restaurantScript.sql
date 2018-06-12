
DROP DATABASE IF EXISTS restaurant4a2017;
CREATE DATABASE restaurant4a2017;
USE restaurant4a2017;

CREATE TABLE tisch (
tischnum INT,
persanz INT NOT NULL CHECK(persanz>=0),
rauch BOOLEAN NOT NULL,
PRIMARY KEY (tischnum)
);

 CREATE TABLE belegung (
 belegdat DATE,
 belegzeit TIME,
 tischnum INT,
 rechnum INT UNIQUE NOT NULL,
 rechstat VARCHAR(255) CHECK (rechstat='offen' OR rechstat='bezahlt' OR rechstat='storniert'),
 PRIMARY KEY (belegdat, belegzeit, tischnum),
 FOREIGN KEY (tischnum)
    REFERENCES tisch (tischnum)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE kategorie (
katbez VARCHAR(255),
mwst FLOAT NOT NULL CHECK (mwst >= 0),
isgetrank BOOLEAN NOT NULL,
PRIMARY KEY (katbez)
);

CREATE TABLE artikel (
artbez VARCHAR(255),
katbez VARCHAR(255) NOT NULL,
bruttpr DECIMAL(6,2) NOT NULL,
isvegetarisch BOOLEAN NOT NULL,
version INT,
PRIMARY KEY (artbez),
FOREIGN KEY (katbez)
    REFERENCES kategorie (katbez)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE bestellung (
reinfolg SERIAL,
tischnum INT,
belegdat DATE,
belegzeit TIME,
artbez VARCHAR(255),
bestanz INT NOT NULL,
beststat VARCHAR(255) CHECK (beststat='bestellt' OR beststat='in Arbeit' OR beststat='fertig'),
PRIMARY KEY (reinfolg, tischnum, belegdat, belegzeit, artbez),
FOREIGN KEY (tischnum, belegdat, belegzeit)
	REFERENCES belegung (tischnum, belegdat, belegzeit)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
FOREIGN KEY (artbez)
	REFERENCES artikel (artbez)
	ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO kategorie VALUES('Alkoholische Getränke', 35, TRUE);
INSERT INTO kategorie VALUES('Alkoholfreie Getränke', 20, TRUE);
INSERT INTO kategorie VALUES('Vorspeise', 20, FALSE);
INSERT INTO kategorie VALUES('Hauptspeise', 20, FALSE);
INSERT INTO kategorie VALUES('Nachspeise', 20, FALSE);

-- maniak

INSERT INTO tisch VALUES(221, 4, false);
INSERT INTO tisch VALUES(222, 4, true);
INSERT INTO tisch VALUES(223, 8, false);
INSERT INTO tisch VALUES(224, 8, true);
INSERT INTO tisch VALUES(225, 10, false);

INSERT INTO belegung VALUES('2017-10-12', '14:04:24', 225, 221, 'offen');
INSERT INTO belegung VALUES('2017-10-12', '14:37:59', 224, 222, 'storniert');
INSERT INTO belegung VALUES('2017-10-12', '15:02:20', 223, 223, 'offen');
INSERT INTO belegung VALUES('2017-10-12', '17:54:44', 222, 224, 'bezahlt');
INSERT INTO belegung VALUES('2017-10-12', '18:44:34', 221, 225, 'offen');

INSERT INTO artikel VALUES('Thunfischspaghetti', 'Hauptspeise', 12.50, false,0);
INSERT INTO artikel VALUES('Waffeln', 'Nachspeise', 4.70, false,0);
INSERT INTO artikel VALUES('Gemüsesuppe', 'Vorspeise', 6.80, false,0);
INSERT INTO artikel VALUES('Orangensaft', 'Alkoholfreie Getränke', 2.70, false,0);
INSERT INTO artikel VALUES('Pizza Diavolo', 'Hauptspeise', 10.90, false,0);

INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(225, '2017-10-12', '14:04:24', 'Waffeln', 3, 'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(224, '2017-10-12', '14:37:59', 'Thunfischspaghetti', 2, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(223, '2017-10-12', '15:02:20', 'Gemüsesuppe', 4, 'in Arbeit');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(222, '2017-10-12', '17:54:44', 'Orangensaft', 4, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(221, '2017-10-12', '18:44:34', 'Pizza Diavolo', 2, 'in Arbeit');

-- schlegel

INSERT INTO kategorie VALUES('Beilage', 20, FALSE);

INSERT INTO artikel VALUES('Pizza Margherita', 'Hauptspeise', 5.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Funghi', 'Hauptspeise', 6.50, TRUE,0);
INSERT INTO artikel VALUES('Pizza Diavolo', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Capricciosa', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Calzone', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Tonno', 'Hauptspeise', 7.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Al Gorgonzola', 'Hauptspeise', 7.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Calimero', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Provenciale', 'Hauptspeise', 8.20, FALSE,0);
INSERT INTO artikel VALUES('Pizza Mozzi', 'Hauptspeise', 7.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Bauer', 'Hauptspeise', 8.20, FALSE,0);
INSERT INTO artikel VALUES('Pizza Salerno', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Quattro Formaggi', 'Hauptspeise', 8.20, TRUE,0);
INSERT INTO artikel VALUES('Pizza Vegetariana', 'Hauptspeise', 7.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Frutti di Mare', 'Hauptspeise', 8.90, TRUE,0);
INSERT INTO artikel VALUES('Pizza Hawaii', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Della Casa', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Firenze', 'Hauptspeise', 7.90, FALSE,0);
INSERT INTO artikel VALUES('Pizza Di Carne', 'Hauptspeise', 7.20, FALSE,0);
INSERT INTO artikel VALUES('Pizzabrot', 'Beilage', 2.00, FALSE,0);

-- aydin

INSERT INTO tisch VALUES(10, 4, False);
INSERT INTO tisch VALUES(9, 4, False);

INSERT INTO belegung VALUES('2017-09-22', '11:42:19', 10, 4234231, 'bezahlt');
INSERT INTO belegung VALUES('2017-09-22', '11:53:45', 9, 4234232, 'offen');

INSERT INTO artikel VALUES('Coca-Cola', 'Alkoholfreie Getränke', 1.4, false,0);
INSERT INTO artikel VALUES('Pepsi', 'Alkoholfreie Getränke', 1.4, false,0);
INSERT INTO artikel VALUES('Steak', 'Hauptspeise', 8, false,0);
INSERT INTO artikel VALUES('Schnitzel', 'Hauptspeise', 4, false,0);
INSERT INTO artikel VALUES('Kartoffelsalat', 'Hauptspeise', 3, true,0);
INSERT INTO artikel VALUES('Barsch', 'Hauptspeise', 5, false,0);
INSERT INTO artikel VALUES('Filet', 'Hauptspeise', 8, false,0);


INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(10, '2017-09-22', '11:42:19', 'Coca-Cola', 1, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(10, '2017-09-22', '11:42:19', 'Kartoffelsalat', 2, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(9, '2017-09-22', '11:53:45', 'Pepsi', 1, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(9, '2017-09-22', '11:53:45', 'Steak', 2,'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(9, '2017-09-22', '11:53:45', 'Filet', 2, 'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES(10, '2017-09-22', '11:42:19', 'Barsch', 2, 'fertig');

-- joksch

INSERT INTO tisch VALUES(45, 10, false);
INSERT INTO tisch VALUES(46, 5, false);
INSERT INTO tisch VALUES(47, 4, true);
INSERT INTO tisch VALUES(48, 4, false);
INSERT INTO tisch VALUES(49, 6, false);

INSERT INTO artikel VALUES('Johannisbeersaft', 'Alkoholfreie Getränke', 2.50, true,0);
INSERT INTO artikel VALUES('Roter Traubensaft', 'Alkoholfreie Getränke', 2.50, true,0);
INSERT INTO artikel VALUES('Weißer Traubensaft', 'Alkoholfreie Getränke', 2.50, true,0);
INSERT INTO artikel VALUES('Klopfer', 'Alkoholische Getränke', 2.50, false,0);
INSERT INTO artikel VALUES('Jägermeister', 'Alkoholische Getränke', 2.50, false,0);
INSERT INTO artikel VALUES('Johannisbeerkompott', 'Nachspeise', 4.50, true,0);
INSERT INTO artikel VALUES('Johannisbeerkuchen', 'Nachspeise', 3.50, false,0);
INSERT INTO artikel VALUES('Jägerbrot', 'Hauptspeise', 7.50, false,0);
INSERT INTO artikel VALUES('Jägersteak', 'Hauptspeise', 12.50,false,0);
INSERT INTO artikel VALUES('Jim Beam', 'Alkoholische Getränke', 3.50, false,0);

-- pader-barosch

INSERT INTO tisch VALUES (5, 8, false);
INSERT INTO tisch VALUES (6, 4, false);
INSERT INTO tisch VALUES (7, 2, false);
INSERT INTO tisch VALUES (8, 2, false);
INSERT INTO tisch VALUES (11, 2, false);

INSERT INTO belegung VALUES ('2017-10-31', '20:30:00', 5, 37, 'offen');
INSERT INTO belegung VALUES ('2017-11-1', '20:30:00', 7, 54, 'bezahlt');
INSERT INTO belegung VALUES ('2017-11-2', '20:30:00', 5, 67, 'storniert');
INSERT INTO belegung VALUES ('2017-11-3', '20:30:00', 11, 98, 'offen');
INSERT INTO belegung VALUES ('2017-11-4', '20:30:00', 6, 101, 'offen');

INSERT INTO artikel VALUES ('Schweinsbraten', 'Hauptspeise', 14.9, false,0);
INSERT INTO artikel VALUES ('Zwiebelrostbraten', 'Hauptspeise', 17.9, false,0);
INSERT INTO artikel VALUES ('Gin Tonic', 'Alkoholfreie Getränke', 5.9, true,0);
INSERT INTO artikel VALUES ('Papaya Limonade', 'Alkoholfreie Getränke', 2.5, true,0);
INSERT INTO artikel VALUES ('Limetten Radler', 'Alkoholfreie Getränke', 3.9, true,0);
INSERT INTO artikel VALUES ('Zitronen Radler', 'Alkoholfreie Getränke', 3.9, true,0);
INSERT INTO artikel VALUES ('Orangen Radler', 'Alkoholfreie Getränke', 3.9, true,0);
INSERT INTO artikel VALUES ('Cordon Bleu', 'Hauptspeise', 7.9, false,0);
INSERT INTO artikel VALUES ('Kartoffel Gulasch', 'Hauptspeise', 8.9, true,0);
INSERT INTO artikel VALUES ('Szegediner Gulasch', 'Hauptspeise', 11.9, false,0);

-- vicovac

INSERT INTO artikel VALUES ('Ratatouille','Hauptspeise', 4, True,0);
INSERT INTO artikel VALUES ('Ravioliauflauf' ,'Hauptspeise', 4, True,0);
INSERT INTO artikel VALUES ('Ranger Cookies','Nachspeise' , 4, True,0);
INSERT INTO artikel VALUES ('Raffaelo Eis' ,'Nachspeise', 4, True,0);
INSERT INTO artikel VALUES ('Ratatouille - Suppe' ,'Vorspeise', 4, True,0);
INSERT INTO artikel VALUES ('Rahmkipferl','Hauptspeise' , 4, True,0);
INSERT INTO artikel VALUES ('Reissuppe','Hauptspeise' , 4, True,0);
INSERT INTO artikel VALUES ('Rahmschnitzel' ,'Hauptspeise', 5, False,0);
INSERT INTO artikel VALUES ('Rindslungenbraten ao la Kratky','Hauptspeise' , 4, False,0);
INSERT INTO artikel VALUES ('Rinderhüftsteak','Hauptspeise' , 4, False,0);
INSERT INTO artikel VALUES ('Rindfleich aus dem WOK','Hauptspeise' , 4, False,0);
INSERT INTO artikel VALUES ('Rindslungenbraten a la Kratky' ,'Hauptspeise', 4, False,0);
INSERT INTO artikel VALUES ('Rindsragout in Rotweinsouce' ,'Hauptspeise', 4, False,0);
INSERT INTO artikel VALUES ('Rosenkohlauflauf','Hauptspeise' , 4, True,0);
INSERT INTO artikel VALUES ('Räucherforellen - Lasagne','Hauptspeise' , 4, True,0);

INSERT INTO tisch VALUES (85, 8 , True);
INSERT INTO tisch VALUES (86, 6 , True);
INSERT INTO tisch VALUES (87, 4 , FALSE);
INSERT INTO tisch VALUES (88, 2 , True);
INSERT INTO tisch VALUES (89, 20, FALSE);


INSERT INTO belegung VALUES('2017-10-11', '21:00:00', 85, 1872892374, 'bezahlt');
INSERT INTO belegung VALUES('2017-10-12', '22:00:00', 86, 1872892373, 'bezahlt');
INSERT INTO belegung VALUES('2017-10-13', '23:00:00', 87, 1872892375, 'bezahlt');
INSERT INTO belegung VALUES('2017-10-19', '18:00:00', 88, 1872892371, 'bezahlt');
INSERT INTO belegung VALUES('2017-10-22', '17:30:00', 89, 1872892376, 'bezahlt');

INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES (85, '2017-10-11', '21:00:00', 'Rahmschnitzel', 3, 'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES (86, '2017-10-12', '22:00:00', 'Rindslungenbraten a la Kratky', 2, 'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES (87, '2017-10-13', '23:00:00', 'Räucherforellen - Lasagne', 4, 'bestellt');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES (88, '2017-10-19', '18:00:00', 'Raffaelo Eis', 1, 'fertig');
INSERT INTO bestellung (tischnum, belegdat, belegzeit, artbez, bestanz, beststat) VALUES (89, '2017-10-22', '17:30:00', 'Ranger Cookies', 5, 'in Arbeit');

-- bruckner Dario

INSERT INTO artikel VALUES ('Debiziner', 'Hauptspeise', 10.0, FALSE,0);
INSERT INTO artikel VALUES ('Dampfnudeln', 'Nachspeise', 15.0, TRUE,0);
INSERT INTO artikel VALUES ('Datteln', 'Vorspeise', 20.0, TRUE,0);
INSERT INTO artikel VALUES ('Dinkelbrot', 'Hauptspeise', 5.0, TRUE,0);
INSERT INTO artikel VALUES ('Doener', 'Hauptspeise', 17.0, FALSE,0);
INSERT INTO artikel VALUES ('Dänisches Schnitzel', 'Hauptspeise', 20.0, FALSE,0);
INSERT INTO artikel VALUES ('Dänischer Kuchen', 'Nachspeise', 10.0, TRUE,0);
INSERT INTO artikel VALUES ('Datteln in Speck', 'Hauptspeise', 19.0, FALSE,0);
INSERT INTO artikel VALUES ('Dänische Eierspeise', 'Vorspeise', 5.0, TRUE,0);
INSERT INTO artikel VALUES ('Dänische Grießknödelsuppe', 'Vorspeise', 17.0, FALSE,0);
INSERT INTO artikel VALUES ('Dänisches Steak vom Rind', 'Hauptspeise', 17.0, FALSE,0);


INSERT INTO tisch VALUES(500, 4, FALSE);
INSERT INTO tisch VALUES(501, 6, TRUE);
INSERT INTO tisch VALUES(502, 2, FALSE);
INSERT INTO tisch VALUES(503, 10, FALSE);
INSERT INTO tisch VALUES(504, 4, TRUE);
INSERT INTO tisch VALUES(505, 4, FALSE);
INSERT INTO tisch VALUES(506, 2, TRUE);
INSERT INTO tisch VALUES(507, 7, FALSE);
INSERT INTO tisch VALUES(508, 9, FALSE);



