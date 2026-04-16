begin;

-- 1) Schema usage
grant usage on schema "CartaDigitalLM" to anon, authenticated;

-- 2) Table grants
grant select on table "CartaDigitalLM"."Categorias" to anon, authenticated;
grant select on table "CartaDigitalLM"."Menu" to anon, authenticated;
grant select, insert, update, delete on table "CartaDigitalLM"."Perfil" to authenticated;
grant select, insert, update, delete on table "CartaDigitalLM"."Categorias" to authenticated;
grant select, insert, update, delete on table "CartaDigitalLM"."Menu" to authenticated;

-- If Categorias/Menu use serial or identity ids, inserts from the admin need sequence access.
grant usage, select on all sequences in schema "CartaDigitalLM" to authenticated;

-- 3) Public profile view
create or replace view "CartaDigitalLM"."Perfil_publico" as
select
  user_id,
  nombre,
  portada_url,
  telefono,
  direccion,
  reviews_url,
  slug,
  google_place_id,
  wifi_name,
  color_principal,
  plato_imagen_default_url,
  logo_url,
  personalizacion_menu
from "CartaDigitalLM"."Perfil";

grant select on table "CartaDigitalLM"."Perfil_publico" to anon, authenticated;

-- 4) RLS
alter table "CartaDigitalLM"."Perfil" enable row level security;
alter table "CartaDigitalLM"."Categorias" enable row level security;
alter table "CartaDigitalLM"."Menu" enable row level security;

-- Perfil: owner only
drop policy if exists perfil_owner_select on "CartaDigitalLM"."Perfil";
create policy perfil_owner_select
on "CartaDigitalLM"."Perfil"
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists perfil_owner_insert on "CartaDigitalLM"."Perfil";
create policy perfil_owner_insert
on "CartaDigitalLM"."Perfil"
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists perfil_owner_update on "CartaDigitalLM"."Perfil";
create policy perfil_owner_update
on "CartaDigitalLM"."Perfil"
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists perfil_owner_delete on "CartaDigitalLM"."Perfil";
create policy perfil_owner_delete
on "CartaDigitalLM"."Perfil"
for delete
to authenticated
using (auth.uid() = user_id);

-- Categorias: public read active, owner CRUD
drop policy if exists categorias_public_read on "CartaDigitalLM"."Categorias";
create policy categorias_public_read
on "CartaDigitalLM"."Categorias"
for select
to anon, authenticated
using (coalesce(activa, false) = true);

drop policy if exists categorias_owner_select on "CartaDigitalLM"."Categorias";
create policy categorias_owner_select
on "CartaDigitalLM"."Categorias"
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists categorias_owner_insert on "CartaDigitalLM"."Categorias";
create policy categorias_owner_insert
on "CartaDigitalLM"."Categorias"
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists categorias_owner_update on "CartaDigitalLM"."Categorias";
create policy categorias_owner_update
on "CartaDigitalLM"."Categorias"
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists categorias_owner_delete on "CartaDigitalLM"."Categorias";
create policy categorias_owner_delete
on "CartaDigitalLM"."Categorias"
for delete
to authenticated
using (auth.uid() = user_id);

-- Menu: public read active, owner CRUD
drop policy if exists menu_public_read on "CartaDigitalLM"."Menu";
create policy menu_public_read
on "CartaDigitalLM"."Menu"
for select
to anon, authenticated
using (coalesce(activo, false) = true);

drop policy if exists menu_owner_select on "CartaDigitalLM"."Menu";
create policy menu_owner_select
on "CartaDigitalLM"."Menu"
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists menu_owner_insert on "CartaDigitalLM"."Menu";
create policy menu_owner_insert
on "CartaDigitalLM"."Menu"
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists menu_owner_update on "CartaDigitalLM"."Menu";
create policy menu_owner_update
on "CartaDigitalLM"."Menu"
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists menu_owner_delete on "CartaDigitalLM"."Menu";
create policy menu_owner_delete
on "CartaDigitalLM"."Menu"
for delete
to authenticated
using (auth.uid() = user_id);

-- 5) RPCs in public
create or replace function public.imenu_get_wifi_by_user(p_user_id uuid, p_pin text)
returns table (wifi_pass text)
language sql
security definer
set search_path = public, "CartaDigitalLM"
as $$
  select p.wifi_pass
  from "CartaDigitalLM"."Perfil" p
  where p.user_id = p_user_id
    and p.wifi_pin = p_pin
    and p.wifi_pass is not null
  limit 1;
$$;

grant execute on function public.imenu_get_wifi_by_user(uuid, text) to anon, authenticated;

create or replace function public.imenu_set_wifi_pin(p_pin text)
returns void
language sql
security definer
set search_path = public, "CartaDigitalLM"
as $$
  update "CartaDigitalLM"."Perfil"
  set wifi_pin = p_pin
  where user_id = auth.uid();
$$;

grant execute on function public.imenu_set_wifi_pin(text) to authenticated;

commit;
