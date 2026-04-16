begin;

-- Plantilla demo para la carta del usuario:
-- https://phinxed.github.io/Carta-digital-producto/?cliente=88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91
-- Sustituye el UUID si quieres usarla para otro perfil.

insert into "CartaDigitalLM"."Perfil" (user_id)
values ('88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91')
on conflict (user_id) do nothing;

update "CartaDigitalLM"."Perfil"
set
  nombre = coalesce(nullif(nombre, ''), 'Bar Tropical'),
  slug = coalesce(nullif(slug, ''), 'bar-tropical'),
  portada_url = coalesce(nullif(portada_url, ''), 'demo/bar-tropical/cover.svg'),
  color_principal = coalesce(nullif(color_principal, ''), '#E2B24C'),
  plato_imagen_default_url = coalesce(
    nullif(plato_imagen_default_url, ''),
    'demo/bar-tropical/plate-default.svg'
  )
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91';

do $$
begin
  if to_regclass('"CartaDigitalLM"."Menus"') is not null then
    delete from "CartaDigitalLM"."Menus"
    where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91';
  end if;
end $$;

-- Reemplaza la carta actual de este usuario por la plantilla demo.
delete from "CartaDigitalLM"."Menu"
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91';

delete from "CartaDigitalLM"."Categorias"
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91';

insert into "CartaDigitalLM"."Categorias" (
  nombre,
  user_id,
  activa,
  orden
)
values
  ('Cocteles de autor', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 0),
  ('Tapas para compartir', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 1),
  ('Burgers y brioche', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 2),
  ('Bowls y frescos', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 3),
  ('Arroces y mar', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 4),
  ('Postres', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 5),
  ('Cafe y brunch', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 6),
  ('Cervezas y vermut', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 7),
  ('Cocina del dia', '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91', true, 8);

insert into "CartaDigitalLM"."Menu" (
  plato,
  descripcion,
  precio,
  categoria_id,
  subcategoria,
  imagen_url,
  user_id,
  activo,
  orden
)
values
  (
    'Mojito Tropical',
    'Ron blanco, hierbabuena fresca, lima y un toque de fruta de la pasion.',
    9.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocteles de autor' limit 1),
    'Clasicos',
    'demo/bar-tropical/cocteles.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Pina Sunset',
    'Pina colada ligera con espuma de coco y acabado citrico.',
    10.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocteles de autor' limit 1),
    'Firma',
    'demo/bar-tropical/cocteles.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Maracuya Spritz',
    'Aperitivo aromatico con burbuja fina, maracuya y naranja.',
    9.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocteles de autor' limit 1),
    'Firma',
    'demo/bar-tropical/cocteles.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Coco Mule',
    'Version caribena del mule con jengibre, coco y lima.',
    10.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocteles de autor' limit 1),
    'Firma',
    'demo/bar-tropical/cocteles.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Espresso Caribe',
    'Vodka, cafe espresso y licor tostado con crema suave.',
    11.00,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocteles de autor' limit 1),
    'After dinner',
    'demo/bar-tropical/cocteles.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Patatas bravas cremosas',
    'Dados crujientes con salsa brava casera y alioli suave.',
    7.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Tapas para compartir' limit 1),
    'Clasicos',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Croquetas de jamon iberico',
    'Bechamel cremosa y rebozado fino, recien fritas.',
    8.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Tapas para compartir' limit 1),
    'Clasicos',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Nachos del muelle',
    'Tortilla chips con cheddar, pico de gallo, guacamole y crema agria.',
    10.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Tapas para compartir' limit 1),
    'Para compartir',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Bao de pollo crispy',
    'Pan bao vapor, pollo crujiente, pepinillo y mayo spicy.',
    9.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Tapas para compartir' limit 1),
    'Street',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Tacos de cochinita',
    'Tortilla de maiz, cochinita melosa y cebolla encurtida.',
    11.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Tapas para compartir' limit 1),
    'Street',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Tropical Smash',
    'Doble smash burger, cheddar, bacon, cebolla crispy y salsa tropical.',
    13.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Burgers y brioche' limit 1),
    'Smash',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Chicken Mango Club',
    'Pollo crujiente, mayo de mango, lechuga y brioche tostado.',
    12.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Burgers y brioche' limit 1),
    'Chicken',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'BBQ Pineapple Burger',
    'Ternera jugosa, salsa BBQ ahumada y pina asada.',
    13.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Burgers y brioche' limit 1),
    'Firma',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Veggie Coral Burger',
    'Burger vegetal, hummus especiado, tomate y brotes.',
    12.40,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Burgers y brioche' limit 1),
    'Veggie',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Doble cheddar picante',
    'Carne doble, cheddar fundido, jalapeno y cebolla morada.',
    14.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Burgers y brioche' limit 1),
    'Smash',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Bowl mediterraneo',
    'Quinoa, hummus, tomate cherry, pepino y aceituna negra.',
    11.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Bowls y frescos' limit 1),
    'Bowls',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Poke salmon tropical',
    'Arroz sushi, salmon marinado, aguacate, edamame y mango.',
    13.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Bowls y frescos' limit 1),
    'Poke',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Cesar crunchy',
    'Lechuga romana, pollo crujiente, parmesano y pan tostado.',
    12.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Bowls y frescos' limit 1),
    'Ensaladas',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Burrata garden',
    'Tomate de temporada, burrata cremosa, pesto verde y focaccia.',
    13.10,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Bowls y frescos' limit 1),
    'Ensaladas',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Tartar fresco de atun',
    'Atun aliñado, aguacate, sesamo y chips de wanton.',
    14.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Bowls y frescos' limit 1),
    'Frescos',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Arroz meloso de gamba',
    'Arroz cremoso con fondo intenso y gamba roja salteada.',
    16.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Arroces y mar' limit 1),
    'Arroces',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Paella del puerto',
    'Arroz seco con mejillon, calamar y gamba.',
    17.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Arroces y mar' limit 1),
    'Arroces',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Calamar a la andaluza',
    'Aros finos, fritura ligera y lima fresca.',
    12.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Arroces y mar' limit 1),
    'Mar',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Pulpo glaseado',
    'Pulpo tierno sobre pure especiado y aceite ahumado.',
    18.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Arroces y mar' limit 1),
    'Mar',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Salmon a la brasa',
    'Lomo jugoso con verduras crujientes y salsa citrica.',
    17.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Arroces y mar' limit 1),
    'Brasa',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Tarta de queso tostada',
    'Interior cremoso con base fina de galleta.',
    6.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Postres' limit 1),
    'Cremosos',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Torrija brioche',
    'Caramelizada al momento con helado de vainilla.',
    6.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Postres' limit 1),
    'Calientes',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Brownie de cacao intenso',
    'Chocolate fundente, nuez y salsa de toffee.',
    6.40,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Postres' limit 1),
    'Chocolate',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Lemon pie fresh',
    'Crema citrica, merengue suave y base crujiente.',
    6.30,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Postres' limit 1),
    'Frescos',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Coulant tropical',
    'Bizcocho caliente con centro de chocolate y helado de coco.',
    7.10,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Postres' limit 1),
    'Chocolate',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Brunch benedict',
    'Huevos poche, bacon crujiente y salsa holandesa.',
    11.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cafe y brunch' limit 1),
    'Brunch',
    'demo/bar-tropical/cafes.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Tostada de aguacate',
    'Pan de masa madre, aguacate, lima y semillas.',
    8.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cafe y brunch' limit 1),
    'Brunch',
    'demo/bar-tropical/cafes.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Croissant relleno de pistacho',
    'Masa hojaldrada con crema suave y pistacho tostado.',
    4.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cafe y brunch' limit 1),
    'Bakery',
    'demo/bar-tropical/cafes.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Flat white',
    'Cafe espresso con leche sedosa y taza corta.',
    2.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cafe y brunch' limit 1),
    'Cafe',
    'demo/bar-tropical/cafes.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Iced latte vainilla',
    'Cafe frio, leche cremosa y un punto de vainilla.',
    3.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cafe y brunch' limit 1),
    'Cafe',
    'demo/bar-tropical/cafes.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),

  (
    'Vermut de la casa',
    'Servido con naranja fresca y aceituna alinada.',
    4.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cervezas y vermut' limit 1),
    'Vermut',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Cana dorada',
    'Cerveza rubia de tirador, fresca y equilibrada.',
    2.70,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cervezas y vermut' limit 1),
    'Tirador',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Tercio IPA',
    'Lupulo aromatico, amargor amable y final citrico.',
    4.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cervezas y vermut' limit 1),
    'Botella',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Radler citrica',
    'Refrescante y ligera con notas de limon natural.',
    3.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cervezas y vermut' limit 1),
    'Botella',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Copa de cava brut',
    'Burbuja fina y final seco para aperitivo o brindis.',
    4.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cervezas y vermut' limit 1),
    'Bodega',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  );

insert into "CartaDigitalLM"."Menu" (
  plato,
  descripcion,
  precio,
  categoria_id,
  subcategoria,
  imagen_url,
  user_id,
  activo,
  orden
)
values
  (
    'Crema de calabaza thai',
    'Crema suave con leche de coco, semillas tostadas y aceite especiado.',
    8.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Primer plato',
    'demo/bar-tropical/bowls.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    0
  ),
  (
    'Ensaladilla del puerto',
    'Patata cremosa, atun, piparra, ventresca y mayonesa casera.',
    9.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Primer plato',
    'demo/bar-tropical/tapas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    1
  ),
  (
    'Ravioli de boletus trufados',
    'Pasta fresca rellena con crema de setas, mantequilla noisette y parmesano.',
    12.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Primer plato',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    2
  ),
  (
    'Lasaña melosa de carrillera',
    'Capas finas de pasta, carrillera guisada y bechamel tostada.',
    14.50,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Segundo plato',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    3
  ),
  (
    'Bacalao gratinado con alioli suave',
    'Lomo jugoso con patata panadera y gratinado ligero al horno.',
    16.80,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Segundo plato',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    4
  ),
  (
    'Pollo rustido con patatas panadera',
    'Muslo deshuesado, jugo reducido y romero fresco.',
    14.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Segundo plato',
    'demo/bar-tropical/burgers.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    5
  ),
  (
    'Arroz caldoso marinero',
    'Fondo intenso con gamba, mejillon, calamar y toque de azafran.',
    17.40,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Segundo plato',
    'demo/bar-tropical/arroces.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    6
  ),
  (
    'Tarta fina de manzana',
    'Laminas crujientes, compota especiada y helado de vainilla.',
    6.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Postre',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    7
  ),
  (
    'Flan cremoso de coco',
    'Flan suave con coco tostado, caramelo ligero y lima fresca.',
    5.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Postre',
    'demo/bar-tropical/postres.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    8
  ),
  (
    'Copa de vino de la casa',
    'Vino tinto joven afrutado para menu o mediodia.',
    3.90,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Bebida',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    9
  ),
  (
    'Agua mineral premium',
    'Botella fria de agua mineral con gas o sin gas.',
    2.20,
    (select id from "CartaDigitalLM"."Categorias" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and nombre = 'Cocina del dia' limit 1),
    'Bebida',
    'demo/bar-tropical/cervezas.svg',
    '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
    true,
    10
  );

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'lacteos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Croquetas de jamon iberico', 'Bao de pollo crispy', 'Torrija brioche', 'Croissant relleno de pistacho');

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'huevos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Patatas bravas cremosas', 'Tacos de cochinita', 'Brunch benedict');

update "CartaDigitalLM"."Menu"
set alergenos = array['pescado', 'sesamo']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Poke salmon tropical', 'Tartar fresco de atun');

update "CartaDigitalLM"."Menu"
set alergenos = array['crustaceos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Arroz meloso de gamba', 'Paella del puerto');

update "CartaDigitalLM"."Menu"
set alergenos = array['moluscos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Calamar a la andaluza', 'Pulpo glaseado');

update "CartaDigitalLM"."Menu"
set alergenos = array['lacteos', 'huevos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Tarta de queso tostada', 'Lemon pie fresh', 'Iced latte vainilla', 'Flat white');

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'frutos_secos', 'lacteos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato in ('Brownie de cacao intenso', 'Coulant tropical');

update "CartaDigitalLM"."Menu"
set alergenos = array['lacteos', 'apio']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Crema de calabaza thai';

update "CartaDigitalLM"."Menu"
set alergenos = array['huevos', 'pescado', 'mostaza']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Ensaladilla del puerto';

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'huevos', 'lacteos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Ravioli de boletus trufados';

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'lacteos', 'apio']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Lasaña melosa de carrillera';

update "CartaDigitalLM"."Menu"
set alergenos = array['pescado', 'huevos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Bacalao gratinado con alioli suave';

update "CartaDigitalLM"."Menu"
set alergenos = array['apio']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Pollo rustido con patatas panadera';

update "CartaDigitalLM"."Menu"
set alergenos = array['crustaceos', 'moluscos', 'pescado']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Arroz caldoso marinero';

update "CartaDigitalLM"."Menu"
set alergenos = array['gluten', 'lacteos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Tarta fina de manzana';

update "CartaDigitalLM"."Menu"
set alergenos = array['huevos', 'lacteos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Flan cremoso de coco';

update "CartaDigitalLM"."Menu"
set alergenos = array['sulfitos']
where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
  and plato = 'Copa de vino de la casa';

do $$
begin
  if to_regclass('"CartaDigitalLM"."Menus"') is null then
    return;
  end if;

  insert into "CartaDigitalLM"."Menus" (
    user_id,
    nombre,
    descripcion,
    activo,
    publicado,
    auto_publicacion,
    orden
  )
  values
    (
      '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
      'Menu mediodia tropical',
      'Primero, segundo, postre y bebida con platos de cocina casera.',
      true,
      true,
      false,
      0
    ),
    (
      '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
      'Menu arroz y mar',
      'Selecciones con entrante, arroz o pescado, dulce y bebida.',
      true,
      true,
      false,
      1
    ),
    (
      '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91',
      'Menu brunch largo',
      'Opciones saladas, dulces y cafe para una carta mas completa.',
      true,
      true,
      false,
      2
    );

  insert into "CartaDigitalLM"."Menus_campos" (
    menu_id,
    nombre,
    descripcion,
    activo,
    permite_multiples,
    orden
  )
  values
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu mediodia tropical'
        limit 1
      ),
      'Primer plato',
      'Elige un primer plato con opciones mas ligeras o cremosas.',
      true,
      true,
      0
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu mediodia tropical'
        limit 1
      ),
      'Segundo plato',
      'Platos mas potentes para el mediodia.',
      true,
      true,
      1
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu mediodia tropical'
        limit 1
      ),
      'Postre',
      'Cierre dulce incluido en el menu.',
      true,
      true,
      2
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu mediodia tropical'
        limit 1
      ),
      'Bebida',
      'Bebidas sencillas para acompanar el menu.',
      true,
      true,
      3
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu arroz y mar'
        limit 1
      ),
      'Entrante',
      'Apertura fresca o frita para compartir.',
      true,
      true,
      0
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu arroz y mar'
        limit 1
      ),
      'Principal',
      'Arroces y mariscos con mas presencia visual.',
      true,
      true,
      1
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu arroz y mar'
        limit 1
      ),
      'Postre',
      'Dulces conocidos para cerrar el menu.',
      true,
      true,
      2
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu arroz y mar'
        limit 1
      ),
      'Bebida',
      'Burbuja o cerveza para completar la experiencia.',
      true,
      true,
      3
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu brunch largo'
        limit 1
      ),
      'Salado',
      'Bloque principal del brunch.',
      true,
      true,
      0
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu brunch largo'
        limit 1
      ),
      'Dulce',
      'Opciones de bolleria y postre.',
      true,
      true,
      1
    ),
    (
      (
        select id
        from "CartaDigitalLM"."Menus"
        where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and nombre = 'Menu brunch largo'
        limit 1
      ),
      'Cafe o bebida',
      'Cafe caliente o versiones frias.',
      true,
      true,
      2
    );

  insert into "CartaDigitalLM"."Menus_campos_platos" (
    menu_campo_id,
    plato_id,
    precio_override,
    notas,
    activo,
    orden
  )
  values
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Primer plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Crema de calabaza thai' limit 1),
      null,
      'Sabor suave y dos alergenos visibles.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Primer plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Ensaladilla del puerto' limit 1),
      null,
      'Opcion fria con tres alergenos.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Primer plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Ravioli de boletus trufados' limit 1),
      null,
      'Pasta fresca para reforzar el bloque de primero.',
      true,
      2
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Segundo plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Lasaña melosa de carrillera' limit 1),
      null,
      'Plato contundente con tres alergenos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Segundo plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Bacalao gratinado con alioli suave' limit 1),
      null,
      'Opcion de pescado gratinado.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Segundo plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Pollo rustido con patatas panadera' limit 1),
      null,
      'Segundo mas clasico de cocina del dia.',
      true,
      2
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Segundo plato'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Arroz caldoso marinero' limit 1),
      null,
      'Opcion con tres alergenos de mar.',
      true,
      3
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Postre'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Tarta fina de manzana' limit 1),
      null,
      'Postre crujiente y ligero.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Postre'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Flan cremoso de coco' limit 1),
      null,
      'Postre suave con dos alergenos.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Copa de vino de la casa' limit 1),
      null,
      'Copa de vino con sulfitos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu mediodia tropical'
          and mc.nombre = 'Bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Agua mineral premium' limit 1),
      null,
      'Sin alergenos.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Entrante'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Calamar a la andaluza' limit 1),
      null,
      'Entrante crujiente con moluscos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Entrante'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Tartar fresco de atun' limit 1),
      null,
      'Version fresca con pescado y sesamo.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Principal'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Arroz meloso de gamba' limit 1),
      null,
      'Arroz intenso con crustaceos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Principal'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Paella del puerto' limit 1),
      null,
      'Arroz seco para compartir.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Principal'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Salmon a la brasa' limit 1),
      null,
      'Principal de brasa con pescado.',
      true,
      2
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Postre'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Tarta de queso tostada' limit 1),
      null,
      'Clasico cremoso con lacteos y huevos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Postre'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Lemon pie fresh' limit 1),
      null,
      'Version citrica y ligera.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Copa de cava brut' limit 1),
      null,
      'Burbuja fina para el maridaje.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu arroz y mar'
          and mc.nombre = 'Bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Cana dorada' limit 1),
      null,
      'Tirador fresco para menu informal.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Salado'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Brunch benedict' limit 1),
      null,
      'Huevos, salsa y pan para brunch clasico.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Salado'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Tostada de aguacate' limit 1),
      null,
      'Opcion mas fresca y vegetal.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Salado'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Bao de pollo crispy' limit 1),
      null,
      'Pieza potente con gluten y lacteos.',
      true,
      2
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Dulce'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Croissant relleno de pistacho' limit 1),
      null,
      'Bakery con gluten, lacteos y frutos secos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Dulce'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Brownie de cacao intenso' limit 1),
      null,
      'Dulce con tres alergenos.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Cafe o bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Flat white' limit 1),
      null,
      'Cafe con lacteos y huevos.',
      true,
      0
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Cafe o bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Iced latte vainilla' limit 1),
      null,
      'Version fria con lacteos y huevos.',
      true,
      1
    ),
    (
      (
        select mc.id
        from "CartaDigitalLM"."Menus_campos" mc
        join "CartaDigitalLM"."Menus" m on m.id = mc.menu_id
        where m.user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91'
          and m.nombre = 'Menu brunch largo'
          and mc.nombre = 'Cafe o bebida'
        limit 1
      ),
      (select id from "CartaDigitalLM"."Menu" where user_id = '88b4b1c8-f270-4f75-90dc-0d5f7c9a0d91' and plato = 'Agua mineral premium' limit 1),
      null,
      'Alternativa sin alergenos.',
      true,
      2
    );
end $$;

commit;

