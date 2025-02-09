# cookingnf

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## STEP
flutter create my_app ;
## FIREBASE NOT IMPLEMENTED
flutter pub add firebase_auth ; flutter pub add firebase_database ;
## IMPORT PACKAGES
import 'package:firebase_auth/firebase_auth.dart'; import 'package:firebase_database/firebase_database.dart';
## INITIALIZE FIREBASE
FirebaseAuth.instance.initialize(); FirebaseDatabase.instance.initialize();

## LINK REF
https://supabase.com/dashboard/new/xuvllfdgumdmirivkedk?projectName=
organization 

## SQL SUPABASE
create table recipes (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users not null,
  title text not null,
  ingredients text[] not null,
  instructions text[] not null,
  is_public boolean default false,
  created_at timestamp with time zone default now()
);

-- Enable Row Level Security (RLS)
alter table recipes enable row level security;

-- Create policies
create policy "Users can insert their own recipes"
  on recipes for insert
  with check (auth.uid() = user_id);

create policy "Users can update their own recipes"
  on recipes for update
  using (auth.uid() = user_id);

create policy "Users can delete their own recipes"
  on recipes for delete
  using (auth.uid() = user_id);

create policy "Users can read their own recipes"
  on recipes for select
  using (auth.uid() = user_id);

create policy "Anyone can read public recipes"
  on recipes for select
  using (is_public = true);

## 2ND 

create or replace function generate_mixed_recipe()
returns json
language plpgsql
as $$
declare
  mixed_recipe json;
begin
  select json_build_object(
    'title', 'Mixed Recipe ' || now(),
    'ingredients', array_agg(distinct i),
    'instructions', array_agg(distinct ins)
  ) into mixed_recipe
  from (
    select unnest(ingredients) as i, unnest(instructions) as ins
    from recipes
    order by random()
    limit 5
  ) subquery;

  return mixed_recipe;
end;
$$;
