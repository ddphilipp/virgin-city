-- Virgin City: cloud saves for Neon Postgres + Managed Better Auth
-- Neon Auth and Neon Data API are enabled on the production branch.
CREATE TABLE IF NOT EXISTS public.game_saves (
  user_id uuid NOT NULL REFERENCES neon_auth."user"(id) ON DELETE CASCADE,
  slot integer NOT NULL CHECK (slot BETWEEN 1 AND 5),
  save_data jsonb NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, slot)
);
ALTER TABLE public.game_saves ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS game_saves_select_own ON public.game_saves;
CREATE POLICY game_saves_select_own ON public.game_saves FOR SELECT TO authenticated USING (user_id = auth.uid());
DROP POLICY IF EXISTS game_saves_insert_own ON public.game_saves;
CREATE POLICY game_saves_insert_own ON public.game_saves FOR INSERT TO authenticated WITH CHECK (user_id = auth.uid());
DROP POLICY IF EXISTS game_saves_update_own ON public.game_saves;
CREATE POLICY game_saves_update_own ON public.game_saves FOR UPDATE TO authenticated USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());
DROP POLICY IF EXISTS game_saves_delete_own ON public.game_saves;
CREATE POLICY game_saves_delete_own ON public.game_saves FOR DELETE TO authenticated USING (user_id = auth.uid());
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.game_saves TO authenticated;
