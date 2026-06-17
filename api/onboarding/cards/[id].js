import { neon } from '@neondatabase/serverless';

const sql = neon(process.env.DATABASE_URL);

function requireAdmin(req) {
  const auth = req.headers.authorization || '';
  const expected = `Bearer ${process.env.ADMIN_SECRET}`;
  return process.env.ADMIN_SECRET && auth === expected;
}

export default async function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store');

  const { id } = req.query;
  if (!id) return res.status(400).json({ error: 'Brak ID w URL' });

  try {
    if (req.method === 'GET') {
      const rows = await sql`SELECT * FROM onboarding_cards WHERE id = ${Number(id)}`;
      if (!rows.length) return res.status(404).json({ error: 'Nie znaleziono' });
      return res.status(200).json(rows[0]);
    }

    if (req.method === 'PUT') {
      if (!requireAdmin(req)) return res.status(401).json({ error: 'Unauthorized' });

      const body = req.body || {};
      const { module, topic, front, back, tags, sort_order } = body;
      const rows = await sql`
        UPDATE onboarding_cards SET
          module = COALESCE(${module ?? null}, module),
          topic = ${topic ?? null},
          front = COALESCE(${front ?? null}, front),
          back = COALESCE(${back ?? null}, back),
          tags = ${tags ?? null},
          sort_order = COALESCE(${sort_order ?? null}, sort_order)
        WHERE id = ${Number(id)}
        RETURNING id, module, topic, front, back, tags, sort_order
      `;
      if (!rows.length) return res.status(404).json({ error: 'Nie znaleziono' });
      return res.status(200).json(rows[0]);
    }

    if (req.method === 'DELETE') {
      if (!requireAdmin(req)) return res.status(401).json({ error: 'Unauthorized' });

      const rows = await sql`DELETE FROM onboarding_cards WHERE id = ${Number(id)} RETURNING id`;
      if (!rows.length) return res.status(404).json({ error: 'Nie znaleziono' });
      return res.status(200).json({ deleted: rows[0].id });
    }

    res.setHeader('Allow', 'GET, PUT, DELETE');
    return res.status(405).json({ error: 'Method not allowed' });
  } catch (e) {
    console.error('API /onboarding/cards/[id] error:', e);
    return res.status(500).json({ error: e.message || 'Internal error' });
  }
}
