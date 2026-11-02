-- شغّلي هذا الكود في Supabase > SQL Editor
create table if not exists public.posts (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 2 and 40),
  message text not null check (char_length(message) between 5 and 500),
  created_at timestamptz not null default now()
);
alter table public.posts enable row level security;
create policy "Everyone can read posts" on public.posts for select to anon using (true);
create policy "Visitors can submit posts" on public.posts for insert to anon with check (true);
grant select, insert on public.posts to anon;
grant usage, select on sequence public.posts_id_seq to anon;
-- تنبيه: النشر المفتوح معرض للرسائل المزعجة. للإطلاق العام طويل المدى
-- أضيفي CAPTCHA وحدود طلبات وإشرافًا لاحقًا.
