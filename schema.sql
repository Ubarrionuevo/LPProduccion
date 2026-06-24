-- ============================================================
-- LPProduccion — Supabase Schema
-- Run this in the Supabase SQL Editor (Dashboard > SQL Editor)
-- ============================================================

-- 1. site_config: global settings & copy
CREATE TABLE site_config (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  key text UNIQUE NOT NULL,
  value text NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- Seed default config
INSERT INTO site_config (key, value) VALUES
  ('hero_title', 'PORTFOLIO'),
  ('hero_subtitle', 'Producción Musical • Mixing • Mastering'),
  ('hero_descripcion', 'Producción Musical • Mixing • Mastering'),
  ('hero_texto_secundario', 'Guitarra, bajo y teclado al servicio de tu visión.'),
  ('btn_escribime', 'Escribime'),
  ('btn_presupuesto', 'Pedime presupuesto'),
  ('cta_principal', 'Escribime'),
  ('cta_presupuesto', 'Pedime presupuesto'),
  ('cta_escuchar', 'Escuchar Muestras'),
  ('hero_bio', 'Beatmaker y multi-instrumentista con dominio en <img src="flstudio.png" alt="FL Studio" class="inline-logo"> y <img src="mega.jpg" alt="Mega" class="inline-logo">. Guitarra, bajo y teclado al servicio de tu visión.'),
  ('muestras_label', 'Mis tracks'),
  ('muestras_title', 'Muestras'),
  ('servicios_label', 'Servicios'),
  ('servicios_title', 'Lo que <em>hago</em>'),
  ('whatsapp_number', '5493858517925'),
  ('instagram_url', 'https://instagram.com/tuinstagram'),
  ('facebook_url', 'https://www.facebook.com/proii.raps.5'),
  ('discord_user', 'ProiiRaps'),
  ('email', 'tucorreo@email.com'),
  ('admin_password', 'admin123');

-- 2. services: pricing cards
CREATE TABLE services (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  description text NOT NULL,
  features jsonb DEFAULT '[]'::jsonb,
  price_label text DEFAULT '',
  price_unit text DEFAULT '',
  badge text DEFAULT '',
  featured boolean DEFAULT false,
  sort_order int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Seed services
INSERT INTO services (name, description, features, price_label, price_unit, badge, featured, sort_order) VALUES
  ('Licencia de Instrumental', 'Cualquier beat del catálogo con licencia para usar en tus proyectos.', '["Uso en plataformas digitales", "Calidad WAV + MP3", "Stems disponibles", "Hasta 50.000 distribuciones"]', '$25', 'USD / beat', '', false, 1),
  ('Mix y Master', 'Hago que tu música suene como tiene que sonar.', '["Mezcla multicanal profesional", "Masterización final", "Listo para plataformas", "1 revisión incluida"]', '$80', 'USD / canción', '', false, 2),
  ('Instrumental Stems', 'Las pistas sueltas de cualquier beat para que mezcles vos.', '["Stems WAV 24bit", "Licencia de uso incluida", "Hasta 100.000 distribuciones", "Descarga inmediata"]', '$15', 'USD / beat', '', false, 3),
  ('Instrumental Personalizado', 'Te armo un beat único desde cero con tu estilo y referencias.', '["Beat exclusivo a medida", "Sesión de referencia incluida", "Revisiones ilimitadas", "Mezcla incluida"]', 'A consultar', '/ proyecto', 'Personalizado', true, 4),
  ('Canción Completa', 'Te produzco la canción completa: beat, mezcla, master y toda la data.', '["Instrumental + Mix + Master", "Asistencia en composición", "Stems + proyecto completo", "Distribución a plataformas"]', 'A consultar', '/ proyecto', 'Recomendado', true, 5);

-- 3. beats: beat library
CREATE TABLE beats (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  category text NOT NULL,
  description text DEFAULT '',
  gif_url text NOT NULL,
  audio_url text NOT NULL,
  sort_order int DEFAULT 0,
  is_akinnno boolean DEFAULT false,
  audio_url_alt text DEFAULT '',
  alt_label text DEFAULT '',
  status text DEFAULT 'available',
  created_at timestamptz DEFAULT now()
);

-- Seed beats
INSERT INTO beats (name, category, description, gif_url, audio_url, sort_order, is_akinnno, audio_url_alt, alt_label, status) VALUES
  ('TRAGIC LOVE', 'Trap & Rap', 'Trap Melódico · 78 BPM', 'tragic_love.gif', 'Tragic_Love_-_Muestra_Portafolio.mp3', 1, false, '', '', 'available'),
  ('THE BEST', 'Trap & Rap', 'Rap · 103 BPM', 'the_best.gif', 'The_Best_-_Muestra_Portafolio.mp3', 2, false, '', '', 'available'),
  ('TRYHARD', 'Trap & Rap', 'Trap · 128 BPM', 'tryhard.gif', 'TryHard_-_Muestra_Portafolio.mp3', 3, false, '', '', 'available'),
  ('FREE HUNTRIX', 'Trap & Rap', 'Trap · 95 BPM', 'free_huntrix.webp', 'FreeHuntrix_-_Muestra_Portafolio.mp3', 4, false, '', '', 'available'),
  ('ME ENAMOR', 'Trap & Rap', 'Rap · 140 BPM', 'me_enamor.gif', 'Me_enamor_-_Portafolio.mp3', 5, false, '', '', 'sold'),
  ('AMAR SIN SABER', 'Trap & Rap', 'Rap · 100 BPM', 'amar_sintemer.webp', 'Amar_sin_saber_-_Portafolio.mp3', 6, false, '', '', 'sold'),
  ('SUPERIOR UNO', 'Rock & Metal', 'Rock', 'superior_uno.webp', 'KOKUSHIBO_-_Muestra_Portafolio.mp3', 7, false, '', '', 'sold'),
  ('VIVIR SIN MIEDO', 'Rock & Metal', 'Rock · 120 BPM', 'VIVIR_SIN_MIEDO_-.gif', 'VIVIR_SIN_MIEDO_-_Muestra_Portafolio.mp3', 8, false, '', '', 'sold'),
  ('GAROU', 'Phonk', 'Phonk · 128 BPM', 'GAROU_-.gif', 'GAROU_-_Muestra_Portafolio.mp3', 9, false, '', '', 'sold'),
  ('AKINNO', 'Mix & Master', 'Mix & Master · Demo', 'AKINNO_-_SIN_MEZCL.gif', 'AKINNO_-_CON_MEZCLA.mp3', 10, true, 'AKINNO_-_SIN_MEZCLA.mp3', 'Sin Mezcla', 'available');

-- 4. Disable RLS (usamos anon key + password propio, no Supabase Auth)
ALTER TABLE site_config DISABLE ROW LEVEL SECURITY;
ALTER TABLE services DISABLE ROW LEVEL SECURITY;
ALTER TABLE beats DISABLE ROW LEVEL SECURITY;

-- 5. Storage bucket "media" — permitir subida/lectura pública
INSERT INTO storage.buckets (id, name, public) VALUES ('media', 'media', true)
ON CONFLICT (id) DO NOTHING;
DROP POLICY IF EXISTS "Public Access" ON storage.objects;
CREATE POLICY "Public Access"
  ON storage.objects FOR ALL
  USING (bucket_id = 'media')
  WITH CHECK (bucket_id = 'media');
