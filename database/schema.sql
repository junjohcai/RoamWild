-- =============================================================================
-- Roamwild Travel Database Schema (Supabase / PostgreSQL)
-- For Application Development Midterm Milestone
-- =============================================================================

-- Step 1: Create the destinations table
create table public.destinations (
    id bigint generated always as identity primary key,
    title text not null,
    location text not null,
    continent text not null,
    badge text not null,
    image text not null,
    alt text not null,
    deleted_at timestamptz,                              -- for soft delete pattern
    created_at timestamptz not null default now()
);

-- Step 2: Habit 1 - Index columns frequently searched or filtered
create index on public.destinations (continent);
create index on public.destinations (deleted_at);
create index on public.destinations (title);

-- Step 3: Lock 1 - Grant access to anonymous users (public publishable key)
grant select, insert, update, delete on public.destinations to anon;

-- Step 4: Lock 2 - Row Level Security (RLS) policies
alter table public.destinations enable row level security;

create policy "read_all"   on public.destinations for select to anon using (true);
create policy "insert_all" on public.destinations for insert to anon with check (true);
create policy "update_all" on public.destinations for update to anon using (true) with check (true);
create policy "delete_all" on public.destinations for delete to anon using (true);

-- Step 5: Seed initial data
insert into public.destinations (title, location, continent, badge, image, alt) values
('Lagoons beyond the map', 'Coron, Philippines', 'Asia', '7 Days', '/images/coron.jpg', 'Coron, Philippines'),
('Slow days under palms', 'Siargao, Philippines', 'Asia', '8 Days', 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2', 'Siargao, Philippines'),
('Barefoot in the blue', 'Baa Atoll, Maldives', 'Asia', '6 Days', 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8', 'Maldives'),
('Kyoto in full bloom', 'Kyoto, Japan', 'Asia', '9 Days', 'https://dynamic-media.tacdn.com/media/photo-o/34/1d/af/f2/caption.jpg?f=webp&w=2400&h=1400', 'Kyoto, Japan'),
('Bamboo Forest Trails', 'Arashiyama, Japan', 'Asia', '5 Days', '/images/bamboo.jpg', 'Arashiyama Bamboo Grove'),
('Temple & Tea Retreat', 'Uji, Japan', 'Asia', '4 Days', '/images/uji.jpg', 'Uji Japan'),
('Ubud Jungle Sanctuary', 'Ubud, Bali', 'Asia', '6 Days', 'https://images.unsplash.com/photo-1537996194471-e657df975ab4', 'Bali Indonesia'),
('High peaks & quiet lakes', 'Bernese Alps, Switzerland', 'Europe', '7 Days', '/images/switzer.jpg', 'Swiss Alps'),
('Matterhorn Base Camp', 'Zermatt, Switzerland', 'Europe', '6 Days', '/images/matterhorn.jpg', 'Zermatt Matterhorn'),
('Glacier Express Route', 'St. Moritz, Switzerland', 'Europe', '5 Days', '/images/express.jpg', 'St Moritz'),
('Path of the Gods', 'Amalfi Coast, Italy', 'Europe', '6 Days', '/images/potg.jpg', 'Amalfi Coast'),
('Caldera Sail & Sunsets', 'Santorini, Greece', 'Europe', '5 Days', '/images/caldera.jpg', 'Santorini Greece'),
('Follow the old caravan road', 'Sahara, Morocco', 'Africa', '8 Days', '/images/sahara.jpg', 'Sahara Desert'),
('Atlas Mountain Kasbahs', 'Marrakech, Morocco', 'Africa', '5 Days', '/images/morocco.jpg', 'Morocco'),
('Wild encounters & golden light', 'Maasai Mara, Kenya', 'Africa', '6 Days', 'https://images.unsplash.com/photo-1516426122078-c23e76319801', 'Maasai Mara'),
('Rift Valley Safari', 'Lake Nakuru, Kenya', 'Africa', '4 Days', 'https://images.unsplash.com/photo-1534567153574-2b12153a87f0', 'Kenya Safari'),
('Untamed peaks & glaciers', 'Patagonia, Chile', 'South America', '7 Days', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTRptrajOFcnDbEBsASDlCj0nVtAWzp9GbwJX9_cHVR-6HHBD3f1ySyqU&s=10', 'Patagonia Chile'),
('The W Trek Explorer', 'Torres del Paine', 'South America', '8 Days', 'https://images4.alphacoders.com/108/1088263.jpg', 'Torres del Paine');


-- =============================================================================
-- Step 6: Create the inquiries (bookings) table
-- Slide 14: Foreign Key connecting inquiries to destinations
-- =============================================================================
create table public.inquiries (
    id bigint generated always as identity primary key,
    destination_id bigint references public.destinations(id) on delete cascade,
    destination_title text not null,
    user_name text not null,
    user_email text not null,
    travel_date text,
    travellers text default '1 traveller',
    status text not null default 'Pending',
    notes text,
    created_at timestamptz not null default now()
);

-- Fast Habit 1: Index foreign keys and email
create index on public.inquiries (destination_id);
create index on public.inquiries (user_email);

-- Permissions and RLS policies
grant select, insert on public.inquiries to anon;
alter table public.inquiries enable row level security;
create policy "insert_inquiries" on public.inquiries for insert to anon with check (true);
create policy "read_inquiries"   on public.inquiries for select to anon using (true);
