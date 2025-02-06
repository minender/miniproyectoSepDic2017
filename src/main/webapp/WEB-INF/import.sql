/**
 * Author:  alejandro
 * Created: Jan 26, 2025
 */

-- Insertar datos en la tabla categoria
INSERT INTO categoria (id, nombre, teoriaid) VALUES
(1, 'Equivalence and true', 1),
(2, 'Negation Inequivalence and false', 1),
(3, 'Disjunction', 1),
(4, 'Conjunction', 1),
(5, 'Implication', 1),
(6, 'Leibniz as an Axiom', 1),
(7, 'Universal Quantification', 1),
(8, 'Existential Quantification', 1),
(9, 'Axioms', 2),
(10, 'Theorems', 2),
(11, 'Otros', 2),
(12, 'General Laws of Quantification', 1),
(14, 'Aritmetic tables', 2),
(13, 'Aritmetic axioms', 2);

-- Configurar secuencia
-- SELECT pg_catalog.setval('categoria_id_seq', 14, true);

-- Insertar datos en la tabla dispone
INSERT INTO dispone (id, numerometateorema, resuelto, loginusuario, metateoremaid) VALUES
(1, 'MetaTheorem1', false, 'user1', 1),
(2, 'MetaTheorem2', true, 'user2', 2);
